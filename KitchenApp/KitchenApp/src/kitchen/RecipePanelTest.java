package kitchen;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.Test;

/**
 * Unit tests for the RecipePanel class.
 *
 * This test suite verifies that recipes are correctly loaded and displayed in the RecipePanel.
 */
public class RecipePanelTest {
    /**
     * Tests the loadRecipe method to ensure that ingredients and steps for a selected recipe
     * are correctly loaded and displayed in the RecipePanel.
     */
    @Test
    public void testLoadRecipes() {
        // Create an instance of RecipePanel
        RecipePanel recipePanel = new RecipePanel();
        
        // Load the "Fried Rice" recipe and check if ingredients and steps are correctly displayed
        recipePanel.loadRecipe("Fried Rice");

        String expectedIngredients = "Ingredients:\n" +
                "Rice: 2 cups\n" +
                "Mixed vegetables: 1 cup\n" +
                "Eggs: 2\n" +
                "Garlic: 2 cloves\n" +
                "Soy sauce: 2 tablespoons\n" +
                "Oil: 2 tablespoons\n";
        String expectedSteps = "Steps:\n" +
                "Heat oil in a large skillet over medium heat.\n" +
                "Add garlic and sauté until fragrant.\n" +
                "Add mixed vegetables and cook until tender.\n" +
                "Push the vegetables to the side and pour beaten eggs into the skillet.\n" +
                "Scramble the eggs until fully cooked.\n" +
                "Add cooked rice to the skillet and stir to combine.\n" +
                "Pour soy sauce and stir everything together.\n" +
                "Cook for another 2-3 minutes and serve hot.\n";

        // Trim the actual text to remove any extra whitespace
        String actualIngredients = recipePanel.getIngredientsArea().getText().trim();
        String actualSteps = recipePanel.getStepsArea().getText().trim();

        // Assert that the displayed ingredients and steps match the expected values
        assertEquals(expectedIngredients.trim(), actualIngredients.trim());
        assertEquals(expectedSteps.trim(), actualSteps.trim());

        // Load the "Spaghetti Bolognese" recipe and check if ingredients and steps are correctly displayed
        recipePanel.loadRecipe("Spaghetti Bolognese");

        expectedIngredients = "Ingredients:\n" +
                "Spaghetti: 200g\n" +
                "Ground beef: 500g\n" +
                "Tomato sauce: 2 cups\n" +
                "Onion: 1\n" +
                "Garlic: 2 cloves\n" +
                "Olive oil: 2 tablespoons\n";
        expectedSteps = "Steps:\n" +
                "Cook spaghetti according to package instructions.\n" +
                "Heat oil in a large skillet over medium heat.\n" +
                "Add chopped onion and garlic, sauté until translucent.\n" +
                "Add ground beef, cook until browned.\n" +
                "Stir in tomato sauce, simmer for 10 minutes.\n" +
                "Serve sauce over spaghetti.\n";

        // Trim the actual text to remove any extra whitespace
        actualIngredients = recipePanel.getIngredientsArea().getText().trim();
        actualSteps = recipePanel.getStepsArea().getText().trim();

        // Assert that the displayed ingredients and steps match the expected values
        assertEquals(expectedIngredients.trim(), actualIngredients.trim());
        assertEquals(expectedSteps.trim(), actualSteps.trim());
    }
}
