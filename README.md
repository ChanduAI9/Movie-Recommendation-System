# Movie-Recommendation-System


### README: Movie Recommendation System

---

#### **Project Title**
**Movie Recommendation System Using Collaborative Filtering**

---

#### **Description**
This project is a web-based **Movie Recommendation System** built using **R** and **Shiny**. The system uses **Collaborative Filtering** (User-Based Collaborative Filtering) to recommend movies to users based on their past ratings and preferences. The application takes user input (previously watched movies) and provides personalized recommendations along with a score for the recommendation.

---

#### **Features**
1. **User-Friendly Interface**:
   - Enter your **User ID** and a list of previously watched movies (comma-separated movie IDs).
   - Click on the "Get Recommendations" button to generate movie suggestions.

2. **Recommendation Logic**:
   - User-Based Collaborative Filtering (UBCF) is used to recommend movies based on similar user preferences.

3. **Scoring Function**:
   - The system calculates a score based on the overlap between the input movies, actual watched movies, and recommended movies.

4. **Customizable Dataset**:
   - Easily replace the dataset file to adapt the app to new movie data.

---

#### **Installation**

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/ChanduAI9/Movie-Recommendation-System.git
   ```

2. **Install R and RStudio**:
   - Ensure you have R and RStudio installed on your system.
   - [Download R](https://cran.r-project.org/)
   - [Download RStudio](https://www.rstudio.com/)

3. **Install Required Packages**:
   Open RStudio and install the necessary libraries by running:
   ```R
   install.packages("data.table")
   install.packages("dplyr")
   install.packages("tidyr")
   install.packages("recommenderlab")
   install.packages("shiny")
   ```

4. **Dataset**:
   - Place your dataset file (`merged_data_final.csv`) in a directory of your choice.
   - Update the file path in the `preprocess_data` function in the server code.

---

#### **How to Run**

1. Open the R script file in RStudio.

2. Run the Shiny app:
   ```R
   shinyApp(ui = ui, server = server)
   ```

3. Open the app in your default web browser. The app will display a user-friendly interface to interact with the recommendation system.

---

#### **Usage**

1. **Input User Data**:
   - Enter your **User ID**.
   - Provide a list of previously watched movie IDs as a comma-separated string (e.g., `101, 102, 103`).

2. **Generate Recommendations**:
   - Click on the "Get Recommendations" button to display recommended movies.

3. **View Output**:
   - The app will show a table with:
     - **Recommended Movies**: A list of suggested movie IDs.
     - **Score**: A numeric score evaluating the recommendation quality.

---

#### **Data Requirements**
The dataset file must:
- Contain the following columns: `userId`, `movieId`, `rating`, and `genres`.
- Be stored in CSV format.
- Use numeric IDs for users and movies.

---

#### **Key Functions**

1. **Preprocessing Data**:
   - Cleans the dataset by removing duplicates and missing values.
   - Normalizes ratings and calculates average ratings.

2. **Creating Rating Matrix**:
   - Converts the data into a user-item rating matrix suitable for collaborative filtering.

3. **Recommendation Model**:
   - Uses the `recommenderlab` library to implement **User-Based Collaborative Filtering**.

4. **Recommendation Scoring**:
   - Evaluates the relevance of recommendations using a custom scoring formula.

---

#### **Dependencies**
- `data.table`: For efficient data manipulation.
- `dplyr`: For data wrangling and transformation.
- `tidyr`: For reshaping data into wide format.
- `recommenderlab`: For building recommendation models.
- `shiny`: For creating the interactive web application.

---

#### **File Structure**

```plaintext
.
├── app.R                   # Main Shiny app script
├── merged_data_final.csv    # Input dataset file (replace with your data)
├── README.md               # Documentation file
```

---

#### **Customization**
1. **Replace the Dataset**:
   - Replace `merged_data_final.csv` with your dataset file and ensure it follows the required structure.
   - Update the file path in the `preprocess_data` function.

2. **Adjust Recommendation Parameters**:
   - Modify the number of recommendations (`n`) in the `predict` function.

---

#### **Contributing**
Feel free to fork this repository and contribute improvements or new features. Submit a pull request for review.

---

#### **Acknowledgments**
- Built using the **R programming language**.
- Powered by the **Shiny framework**.
- Utilized the **recommenderlab** package for collaborative filtering.

---

Enjoy exploring personalized movie recommendations with this interactive system! 🎥🍿
