# 🌐 Internet Protocol Suite

When you type a URL like **https://www.google.com** into your browser, a lot of things happen behind the scenes to **connect your device** (the client) with the **server** where the webpage is stored. The process involves multiple technologies working together seamlessly, and this whole system is called the **Internet Protocol Suite**. 📡✨

While there are entire books written on this topic 📚, let's simplify things and cover the **essential steps** that take place when you load a webpage.

## What Happens When You Type a URL? 🖥️🌐

Let’s break down what happens after you type a URL into your browser and press **Enter**:

1. The browser needs to **find the server** where the website is hosted 🛠️.
2. Once it finds the server, it needs to **communicate** with it to **get the webpage** and display it on your screen 📃.

## Step 1: Finding the Server 🔍

When you type **https://www.google.com**, your browser has to figure out **where** in the vast internet 🌍 the Google server is located.

### Domain Name System (DNS) 📖
Your browser uses something called a **Domain Name Service (DNS)** to convert the **domain name** (like `google.com`) into an **IP address**.

An **IP address** is a unique string of numbers that identifies every device connected to the internet 🌐. For example:

- `google.com` might be translated to the IP address `172.217.164.68`.

The reason we use domain names like `google.com` is because they’re easier to remember 🧠 than a series of numbers like `172.217.164.68`.

### Example 🎯

Let’s say you want to visit a website called **mycoolsite.com**.

1. Your browser sends a request to the **DNS** to find out the **IP address** for `mycoolsite.com`.
2. The DNS returns the IP address, for example, `192.168.1.1`.
3. Now, the browser knows **where** the server is located and can try to connect to it! 🌐

## Step 2: Establishing a Connection 🔗

Once your browser has the **IP address** of the server, it needs to set up a **consistent, reliable connection** so that both your computer (the client) and the server can communicate.

This happens through something called the **Transmission Control Protocol (TCP)**.

### TCP: Transmission Control Protocol 🚀

**TCP** ensures that the data sent between your computer and the server is **reliable, ordered, and error-checked**. It’s like the foundation of the connection, making sure everything runs smoothly without any missing parts.

To set up this connection, TCP uses a **three-way handshake** 🤝 between the client and the server:

1. **Client sends SYN** (Synchronize) 📨: This is like saying, "Hello! Can we start a conversation?"
2. **Server responds with SYN-ACK** (Synchronize-Acknowledge) 📬: The server replies, "Hello! I got your message, and I’m ready to connect."
3. **Client sends ACK** (Acknowledge) 📩: The client says, "Great! Let’s communicate."

Once this handshake is completed, the client and server have successfully established a **TCP connection**.

### Example 🎯

Imagine you want to send a letter ✉️ to a friend.

1. You write a letter (SYN) asking if your friend is home and can chat.
2. Your friend replies with a letter (SYN-ACK) confirming they are home and can talk.
3. You send another letter (ACK) saying, "Great, let's chat."

This simple **back-and-forth** ensures both parties are ready before they start exchanging data. 🗣️📧

## Step 3: Communicating via HTTP 🔄

Now that the **TCP connection** is established, the client and server can **start communicating** using the **HTTP** protocol (Hypertext Transfer Protocol).

- The client (your browser) sends an **HTTP request** to the server, asking for the webpage 📨.
- The server sends back an **HTTP response** with the requested webpage data 📬.
- Your browser then displays the webpage on your screen 📄.

## Quick Recap 📋

1. **DNS Lookup**: The browser translates the domain name (e.g., `google.com`) into an IP address (e.g., `172.217.164.68`) using DNS 🔍.
2. **TCP Handshake**: The client and server establish a reliable connection through a three-step handshake using TCP 🤝.
3. **HTTP Communication**: Once the connection is set, the client sends an HTTP request, and the server responds with the data to display the webpage 🔄.

## Simplified Example 🚀

Here’s a simplified example of what happens when you visit **https://www.google.com**:

1. **DNS** translates `google.com` into its IP address, let’s say `172.217.164.68` 📖.
2. **TCP** creates a connection between your browser and the Google server via a three-way handshake 🤝.
3. Your browser sends an **HTTP request** asking for the homepage 📨.
4. The Google server responds with the necessary data to load the page 📬.
5. You see the **Google homepage** on your screen 🎉.