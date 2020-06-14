# Práctica de ARKit
Realizar un juego en el que hay que disparar y derribar un avión antes de que llegue a su cámara partiendo de una posición aleatoria.

## Objetivos

- El avión contará con una barra de vida cuyo valor total es aleatorio. 
- Hay dos tipos de munición, finita e infinita. La finita resta 2 puntos de vida y la infinita 1. Para obtener más munición finita hay que disparar a una caja de munición.
- El avión debe usar la técnica *billboard camera face*.
- Se almacenará un registro con la puntuación más alta obtenida de todas las partidas.

## Tecnologías

- ARKit.
- MVVM como arquitectura de desarrollo.
- UserDefaults.

## Algunas mejoras sobre los objetivos solicitados

- El color de las balas y su velocidad dependen del tipo de munición.
- Se ha incorporado sonido para cada tipo de munición.
- La velocidad del avión se va incrementado progresivamente según aumentan el número de aviones destruidos (con un máximo para mantener la jugabilidad).
- Se ha creado una estructura Settings donde tener centralizado aquellos valores que pueden modificar el juego. Por un lado está centralizado y por el otro da pie a poder crear una pantalla de configuración para que el usuario la establezca a medida.