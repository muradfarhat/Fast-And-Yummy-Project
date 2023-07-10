## Abstract
The project is an application that enables users to start their own businesses and sell food they have prepared at home without really having a physical store. They can even sign up on the application as employees and distribute food using their own vehicles.
This program is crucial for those who lack the physical ability or available space to create a store physically, since it enables them to launch an online business, which will appeal to the broadest audience.
The user can open his own store, view the foods he sells, and explore the foods sold by other stores in the first area.
The project will use artificial intelligence and machine learning to provide cooking recommendations to the user. In addition, it will include a map showing the route of the order, the estimated time of arrival, and the identity of the person who will make the delivery. Flutter, PHP Rest API, and MySQL are the languages used in the front end and backend of the application, respectively.
There are several similar apps like Uber Eats, but they don't allow people to sell their own food, which isn't available in Palestine, and they only show food from neighboring restaurants with their own menus.

Here is splash screen, signin and signup page 

<img height=510 width=865 src="https://user-images.githubusercontent.com/78206754/209877663-c764674f-fede-4c93-8cfb-99f7d00175ef.jpg"/>

we have used Regular expression to check fields if its vaild

this expression (r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+) to check email
and this to check phone number (r"[05][69][23456789][0-9]{6}$") you can use only mobile start 059 and 056 because I have limited the app for Palestine


When you login the app check if you are customer or delivery employee 

if you're customer you'll go to home screen

## Customer
there is bottom nav bar to move between 5 pages 

<img height=328 width=865 src="https://user-images.githubusercontent.com/78206754/209878835-3f66c886-550e-4e6b-bbce-8afa8ba4fbbd.jpg"/>

In home page you can search, see categories, see populer products, see recommendations

### How recommendation system work 

After you sign up in the app there will be no recommendations 

when you're start buying and rating proudcuts the app use collaborative filters this recommendation system depend on old user reviews, the app trying to find the most users you have correlation with them then the app will start recommend products from there rating.

### Order page 
From order page you can traking your order and see the delivery who will deliver your order 

<img height=328 width=158 src="https://user-images.githubusercontent.com/78206754/209880608-2bc9591e-2273-4f15-9666-7b61fe99f08f.jpg" />

## Your store page
From your store page you can see how many orders in your store, your total earings,edit store name and image, and you can add, remove, edit, and promote products

Promotion : A method that you use when you want to suggest one of your products to users and you can select promotion duration.

<img height=350 width=865 src="https://user-images.githubusercontent.com/78206754/209881079-9efae3b4-799e-45cf-8ee7-754592065138.jpg" />

## Delivery employee
In delivery page the employee can see the orders that he'll deliver, the orders that he already deliverd and he can edit his profile

and he can also open the map and see his location 

<img height=510 width=865 src="https://user-images.githubusercontent.com/78206754/209881519-aac66bf0-5cc9-485d-b364-cfcd4a496cd0.jpg" />


