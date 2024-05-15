import React, { useState } from 'react';
import { Container, styled, TextField, Button, Box, Typography, FormControl, Paper, Grid, useTheme } from '@mui/material';

const StyledPaper = styled(Paper)(({ theme }) => ({
  marginTop: theme.spacing(2),
  padding: theme.spacing(2),
  backgroundColor: '#f7f7f7',
  fontFamily: 'Monospace',
  color: theme.palette.text.secondary,
  whiteSpace: 'pre-wrap', 
  overflowX: 'auto'   
}));

const Footer = styled('footer')(({ theme }) => ({
  marginTop: theme.spacing(8),
  padding: theme.spacing(3),
  backgroundColor: '#e3f2fd',
  color: theme.palette.text.secondary,
  textAlign: 'center'
}));

function App() {
  const theme = useTheme();
  const [orders, setOrders] = useState([{ id: "", date: "", amount: "" }]);
  const [output, setOutput] = useState("");

  const handleInputChange = (index, field, value) => {
    const newOrders = [...orders];
    newOrders[index][field] = value;
    setOrders(newOrders);
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    const response = await fetch('/api/execute', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json;charset=utf-8',
      },
      body: JSON.stringify(orders),
    });
    const data = await response.text();
    setOutput(data);
  };

  const addOrder = () => {
    setOrders([...orders, { id: "", date: "", amount: "" }]);
  };

  return (
    <Box sx={{ flexGrow: 1 }}>
      <Container maxWidth="md" sx={{ my: 4 }}>
        <Typography variant="h4" gutterBottom>
          Añade y ordena pedidos:
        </Typography>
        <form onSubmit={handleSubmit}>
          {orders.map((order, index) => (
            <Box key={index} marginY={2}>
              <TextField
                fullWidth
                label="ID"
                variant="outlined"
                name="id"
                value={order.id}
                onChange={e => handleInputChange(index, 'id', e.target.value)}
                margin="normal"
              />
              <TextField
                fullWidth
                label="Fecha (yyyy-mm-dd)"
                variant="outlined"
                name="date"
                value={order.date}
                onChange={e => handleInputChange(index, 'date', e.target.value)}
                margin="normal"
              />
              <TextField
                fullWidth
                label="Cantidad"
                variant="outlined"
                name="amount"
                value={order.amount}
                onChange={e => handleInputChange(index, 'amount', e.target.value)}
                margin="normal"
              />
            </Box>
          ))}
          <Grid container spacing={2}>
            <Grid item>
              <Button variant="contained" color="primary" onClick={addOrder}>
                Añadir más pedidos
              </Button>
            </Grid>
            <Grid item>
              <Button variant="contained" color="secondary" type="submit">
                Ejecutar
              </Button>
            </Grid>
          </Grid>
          <Typography variant="h4" gutterBottom marginTop={4}>
            Resultados:
          </Typography>
          <StyledPaper elevation={3}>
            {output}
          </StyledPaper>
        </form>
      </Container>
      <Footer>
        <Typography variant="body1">
          Anotaciones con Java.
        </Typography>
        <Typography variant="body2">
          Contacto: <a href="mailto:pablo.arquecebri@alum.uca.es" style={{ color: theme.palette.secondary.main }}>your-email@example.com</a>
        </Typography>
      </Footer>
    </Box>
  );
}

export default App;
