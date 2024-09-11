### Mapping Out Necessary Entities and Relationships

Develop a data model that includes the key entities (e.g., customer, branch, menu items, sales, payments) and the relationships between them.

## Creating a Dimensional Model

- **Business Process:** Sales Analysis

- **Business Questions:**
  - What are the sales trends across different branches and payment methods?
  - How do dining options (dine-in, take-out, online) affect sales?
  - What menu items are performing well in which locations?
- **Grain:** Each transaction (sale).
- **Dimensions:**
  - Location (branch)
  - Time (date, time)
  - Payment Method (cash, card, online gateway)
  - Dining Option (dine-in, take-out, online)
  - Menu Item (specific items sold)
- **Fact:** Sales (transactional data including amount, quantity, and total sales).


#### Step 1: Mapping Entities and Relationships

From the case study, the key entities involved in Fufu Republic's operations can be identified. I'll outline them along with the relationships:

##### Key Entities

- **Customer:** Represents individuals purchasing items (attributes like customer ID, name, contact information).
- **Branch/Location:** Represents the restaurant branches where sales are made (attributes like branch ID, branch name, address).
- **Menu Item:** Represents the food and beverages sold at the branches (attributes like item ID, item name, category, price).
- **Sales Transaction:** Each sale (attributes include transaction ID, date, time, amount, quantity).
- **Payment Method:** Represents the type of payment (attributes like payment method ID, payment method type).
- **Dining Option:** Indicates whether the order is dine-in, take-out, or online (attributes like option ID, option type).

##### Relationships

- A **customer** makes a **sales** transaction at a particular **branch.**
- Each **sales** transaction involves one or more **menu items.**
- **Payment methods** are associated with **each sales transaction.**
- **Dining options** (e.g., dine-in, take-out, online) are specified for **each transaction.**


#### Step 2: Dimensional Model Design

The dimensional model typically consists of a fact table and several dimension tables.

###### Fact Table: Sales Fact

This table will capture the core transactional data, with foreign keys linking to the dimension tables. The measures in this table will help answer questions about total sales, quantities sold, and so on.

Fact Table: Sales_Fact
Transaction_ID (Primary Key)
Date (FK to Time Dimension)
Branch_ID (FK to Branch Dimension)
Payment_Method_ID (FK to Payment Dimension)
Dining_Option_ID (FK to Dining Option Dimension)
Menu_Item_ID (FK to Menu Dimension)
Customer_ID (FK to Customer Dimension)
Quantity Sold
Total_Sales_Amount


###### Dimension Tables

- **Customer Dimension**
  - Customer_ID (Primary Key)
  - Customer_Name
  - Contact_Information

- **Branch Dimension**
  - Branch_ID (Primary Key)
  - Branch_Name
  - Branch_Address
  - Branch_City

- **Menu Dimension**
  - Menu_Item_ID (Primary Key)
  - Item_Name
  - Item_Category (e.g., main course, beverage)
  - Item_Price

- **Payment Method Dimension**
  - Payment_Method_ID (Primary Key)
  - Payment_Type (cash, card, Paystack, etc.)

- **Dining Option Dimension**
  - Dining_Option_ID (Primary Key)
  - Dining_Type (dine-in, take-out, online)

- **Time Dimension**
  - Date (Primary Key)
  - Day
  - Week
  - Month
  - Year
  - Time_of_Day

  
#### Step 3: Business Questions to Address Using the Model
This dimensional model allows Fufu Republic to address the following business questions:

- **Sales Trends:** What are the sales trends across different branches, payment methods, and dining options?
- **Customer Behavior:** What are the purchasing habits of customers, and how can personalized promotions be crafted based on their preferences?
- **Top Selling Items:** What are the top-selling items at each branch?
- **Branch Performance:** Which branches are performing best based on sales and dining options?
- **Inventory Needs:** What are the patterns in menu items sold across locations, helping to maintain stock levels effectively?