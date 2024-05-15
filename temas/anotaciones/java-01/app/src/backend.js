const fs = require('fs');
const express = require('express');
const path = require('path');
const cors = require('cors');
const { exec } = require('child_process');
const app = express();
const PORT = 3200;

app.use(express.json());
app.use(express.static('public'));
app.use(cors());

app.post('/api/execute', (req, res) => {
  const orders = req.body;
  let javaCode = "package main.java; \n";
  javaCode += "import java.time.LocalDate;\n";
  javaCode += "import java.util.*;\n";
  javaCode += "public class Main {\n";
  javaCode += "    public static void main(String[] args) throws IllegalAccessException, InstantiationException {\n";
  javaCode += "        List<Order> orders = new ArrayList<>();\n";

  // Creación dinámica de instancias Order
  orders.forEach(o => {
      javaCode += `        orders.add(new Order(${o.id}, LocalDate.parse("${o.date}"), ${o.amount}));\n`;
  });

  // Inyectar dependencias
  javaCode += "        DependencyInjector injector = new DependencyInjector();\n";
  javaCode += "        for (Order order : orders){injector.inject(order);}\n";
  
  // Ordenar por fecha y mostrar
  javaCode += "        System.out.println(\"Ordenados por fecha:\");\n";
  javaCode += "        orders.sort(Comparator.comparing(Order::getDate).thenComparing(Order::getAmount));\n";
  javaCode += "        orders.forEach(order -> System.out.println(order.getOrderId()));\n";

  // Ordenar por cantidad y mostrar
  javaCode += "        System.out.println(\n\n\"Ordenados por cantidad:\");\n";
  javaCode += "        orders.sort(Comparator.comparing(Order::getAmount));\n";
  javaCode += "        orders.forEach(order -> System.out.println(order.getOrderId()));\n";

  javaCode += "    }\n";
  javaCode += "}\n";

  fs.writeFileSync('./main/java/Main.java', javaCode, 'utf8');

  // Compilación y ejecución del código Java generado
  exec('javac main/java/Main.java && java main.java.Main', (error, stdout, stderr) => {
      if (error) {
          console.error(`exec error: ${error}`);
          return res.status(500).send(stderr);
      }
      res.setHeader('Content-Type', 'text/plain; charset=utf-8')
      res.send(stdout);
  });
});

app.get('*', (req, res) => {
    res.sendFile(path.resolve(__dirname, 'public', 'index.html'));
});

app.listen(PORT, () => console.log(`Server running on http://localhost:${PORT}`));
