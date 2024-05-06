const fs = require('fs');
const express = require('express');
const path = require('path');
const cors = require('cors');
const { exec } = require('child_process');
const app = express();
const PORT = 3100;

app.use(express.json());
app.use(express.static('public'));
app.use(cors());

app.post('/api/execute', (req, res) => {
    const participants = req.body;
    let kotlinCode = "fun main() {\n";
    kotlinCode += "val manager = Manager()\n";
    kotlinCode += "val miembroGrupos = mutableListOf<MiembroGrupo>()\n";
  
    participants.forEach(p => {
      if(p.role == "Cantante y Guitarrista") {  
        kotlinCode += `miembroGrupos.add(CantanteGuitarrista("${p.name}"))\n`;
      } else {
        kotlinCode += `miembroGrupos.add(${p.role}("${p.name}"))\n`;
      }
    });
  
    kotlinCode += "manager.preparaGrupo(miembroGrupos)\n";
    kotlinCode += "manager.actuaGrupo(miembroGrupos)\n";
    kotlinCode += "}\n";
  
    fs.writeFileSync('./kotlin_src/DynamicMain.kt', kotlinCode, 'utf8');
  
    exec('kotlinc ./kotlin_src/DynamicMain.kt ./kotlin_src/MusicBandMembers.kt -include-runtime -d ./kotlin_src/DynamicMain.jar && java -Dfile.encoding=UTF-8 -jar ./kotlin_src/DynamicMain.jar', (error, stdout, stderr) => {
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
