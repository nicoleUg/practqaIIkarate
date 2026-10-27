Feature: Flujo End-to-End y Validación para Users, Posts y Comments

  Background:
    * url 'https://gorest.co.in/public/v2'
    * configure headers = { 'Accept': 'application/json', 'Content-Type': 'application/json', 'Authorization': 'Bearer 700d0c7a86eb84028bf5cd204b11587f812f9d7cd880dc4edbdbd1d407ae9954' }
    * def dataGenerator = Java.type('Utils.DataGenerator')

  Scenario: Obtener lista de Posts y validar aserts
    Given path 'posts'
    When method Get
    Then status 200
    And match response == '#[]'
    And match each response ==
    """
    {
      id: '#number',
      user_id: '#number',
      title: '#string',
      body: '#string'
    }
    """

  Scenario: Obtener lista de Comments y validar aserts
    Given path 'comments'
    When method Get
    Then status 200
    And match response == '#[]'
    And match each response ==
    """
    {
      id: '#number',
      post_id: '#number',
      name: '#string',
      email: '#string',
      body: '#string'
    }
    """

  Scenario: Crear usuario, agregar post, comentar y limpiar base de datos
    
    * def userPayload = dataGenerator.getUserRandom()
    Given path 'users'
    And request userPayload
    When method Post
    Then status 201
    And match response.id == '#present'
    * def userId = response.id 

    Given path 'users', userId, 'posts'
    * def postPayload = { title: "Mi primer post en Karate", body: "Karate hace que las pruebas E2E sean fáciles." }
    And request postPayload
    When method Post
    Then status 201
    And match response.user_id == userId
    * def postId = response.id

    Given path 'posts', postId, 'comments'
    * def commentPayload = { name: "Tester QA", email: "testerqa@fake.com", body: "¡Excelente validación!" }
    And request commentPayload
    When method Post
    Then status 201
    And match response.post_id == postId
    
    Given path 'users', userId
    When method Delete
    Then status 204
    * print 'Flujo finalizado. Usuario de prueba eliminado exitosamente.'