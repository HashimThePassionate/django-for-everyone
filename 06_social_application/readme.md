# **Django Social Website** 🔹

## 📝 Overview

This project enables users to share images, bookmark content from other websites, follow other users, and interact with shared images. Users can like/unlike images, view activity streams, and explore the most viewed images on the platform. Additionally, Redis is integrated to optimize query performance and track item views efficiently.

## 📚 What You Will Learn

### ✅ Authentication & User Management

- Creating a **login view** using Django authentication framework
- Implementing **user registration, login, logout, password change, and password reset views**
- Extending the **User model** with a custom profile model
- Configuring **media file uploads** in Django

### ✅ Image Bookmarking System

- Creating **many-to-many relationships** for image bookmarking
- Customizing behavior in Django forms
- Integrating **JavaScript with Django** for interactive features
- Building a **JavaScript bookmarklet** to share images from external websites
- Generating **image thumbnails** using `easy-thumbnails`
- Implementing **asynchronous HTTP requests** for better user experience
- Developing **infinite scroll pagination** to load images dynamically

### ✅ Social Features & Activity Streams

- Implementing a **follow system** for users
- Creating **an activity stream application** to display user interactions
- Establishing **many-to-many relationships with an intermediate model**
- Utilizing **Django signals** for data denormalization
- Adding **generic relations** to models for flexible content linking
- Optimizing **QuerySets** for efficient data retrieval
- Using **Django Debug Toolbar** to debug and optimize queries

### ✅ Performance Optimization with Redis

- Counting **image views with Redis** for high-performance tracking
- Storing **item views** using Redis's fast I/O storage
- Creating a **ranking system for the most viewed images** using Redis

## 🚀 Features

🔹 **User Authentication:** Secure login/logout, password reset, and registration

🔹 **Image Bookmarking:** Bookmark images from the internet and share with other users

🔹 **Social Interaction:** Follow users, like/unlike images, and see an activity feed

🔹 **JavaScript Bookmarklet:** Quickly save images from external websites

🔹 **Infinite Scroll Pagination:** Seamless browsing experience

🔹 **Redis Integration:** High-performance data storage and analytics

🔹 **Django Signals:** Automate profile creation and data tracking

🔹 **Optimized QuerySets:** Faster database queries for better performance

🔹 **Image Ranking System:** Track and display the most popular images

## 🛠 Technologies Used

- **Django** (Authentication, ORM, Views, Forms)
- **JavaScript** (AJAX, Bookmarklet, Infinite Scroll)
- **Redis** (Item views, Data caching, Ranking system)
- **Easy-Thumbnail** (Image Processing)
- **Django Debug Toolbar** (Performance Optimization)

## 🎯 Conclusion

This project provides an engaging social experience where users can share, interact with, and bookmark images while benefiting from performance optimizations using Django and Redis. The integration of JavaScript enhances user experience with asynchronous functionality, and Redis ensures efficient data handling and query optimization. By completing this project, you will gain hands-on experience in building real-world Django applications with advanced features.

