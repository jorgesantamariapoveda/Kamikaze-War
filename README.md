# Práctica de ARKit
Realizar un juego en el que hay que disparar a un avión que progresivamente se va acercando hacia su cámara. El objetivo es destruirlo antes de que la alcance partiendo de un origen previamente establecido de forma aleatoria.

## Objetivos

- El avión contará con una barra de vida cuyo valor total es aleatotio. 
- Hay dos tipos de munición, finita e infinita. La finita resta 2 puntos de vida y la infinita 1. Para obtener más munición finita hay que disparar a una caja de munición.
- El avión debe usar la técnica *billboard camera face*.
- Se almacenará un registro con la puntuación más alta obtenida de todas las partidas.

## Tecnologías

- ARKit.
- MVVM como arquitectura de desarrollo.
- UserDefaults.