package com.app;
import io.javalin.Javalin;

public class JavalinApp {
    public static void main(String[] args) {
      // Retrieve the value of the PORT environment variable
      String portStr = System.getenv("PORT");
        
      // Default port value if PORT is not set
      int port = 7000; // Default port    

      if (portStr != null && !portStr.isEmpty()) {
        try {
            port = Integer.parseInt(portStr);
        } catch (NumberFormatException e) {
            System.err.println("Invalid port number: " + portStr);
            System.exit(1);
        }
      }

      // Set up Javalin server
      Javalin app = Javalin.create(/*config*/).start(port);

      // Define your routes and configure your application as needed
      app.get("/", ctx -> ctx.result("Hello, World!"));

    }
}