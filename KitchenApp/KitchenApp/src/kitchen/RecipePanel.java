package kitchen;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * RecipePanel class creates a panel for displaying and managing recipes.
 * Users can view predefined recipes or add their own custom recipes.
 */
public class RecipePanel extends JPanel {
    private Map<String, Map<String, List<String>>> recipes;
    private static final Map<String, Map<String, List<String>>> predefinedRecipes = new HashMap<>() {{
        put("Fried Rice", new HashMap<>() {{
            put("ingredients", java.util.Arrays.asList(
                "Rice: 2 cups", 
                "Mixed vegetables: 1 cup", 
                "Eggs: 2", 
                "Garlic: 2 cloves", 
                "Soy sauce: 2 tablespoons", 
                "Oil: 2 tablespoons"
            ));
            put("steps", java.util.Arrays.asList(
                "Heat oil in a large skillet over medium heat.",
                "Add garlic and sauté until fragrant.",
                "Add mixed vegetables and cook until tender.",
                "Push the vegetables to the side and pour beaten eggs into the skillet.",
                "Scramble the eggs until fully cooked.",
                "Add cooked rice to the skillet and stir to combine.",
                "Pour soy sauce and stir everything together.",
                "Cook for another 2-3 minutes and serve hot."
            ));
        }});
        put("Spaghetti Bolognese", new HashMap<>() {{
            put("ingredients", java.util.Arrays.asList(
                "Spaghetti: 200g", 
                "Ground beef: 500g", 
                "Tomato sauce: 2 cups", 
                "Onion: 1", 
                "Garlic: 2 cloves", 
                "Olive oil: 2 tablespoons"
            ));
            put("steps", java.util.Arrays.asList(
                "Cook spaghetti according to package instructions.",
                "Heat oil in a large skillet over medium heat.",
                "Add chopped onion and garlic, sauté until translucent.",
                "Add ground beef, cook until browned.",
                "Stir in tomato sauce, simmer for 10 minutes.",
                "Serve sauce over spaghetti."
            ));
        }});
        put("Pancakes", new HashMap<>() {{
            put("ingredients", java.util.Arrays.asList(
                "Flour: 1 cup", 
                "Milk: 1 cup", 
                "Egg: 1", 
                "Baking powder: 1 tablespoon", 
                "Salt: 1/2 teaspoon", 
                "Butter: 2 tablespoons"
            ));
            put("steps", java.util.Arrays.asList(
                "In a large bowl, mix flour, baking powder, and salt.",
                "Add milk and egg, whisk until smooth.",
                "Heat a skillet over medium heat, melt butter.",
                "Pour batter into the skillet, cook until bubbles form.",
                "Flip and cook until golden brown.",
                "Serve with syrup."
            ));
        }});
        put("Caesar Salad", new HashMap<>() {{
            put("ingredients", java.util.Arrays.asList(
                "Romaine lettuce: 1 head", 
                "Croutons: 1 cup", 
                "Parmesan cheese: 1/2 cup", 
                "Caesar dressing: 1/2 cup", 
                "Chicken breast: 1", 
                "Olive oil: 1 tablespoon"
            ));
            put("steps", java.util.Arrays.asList(
                "Grill chicken breast until cooked through, slice.",
                "Chop romaine lettuce and place in a large bowl.",
                "Add croutons and Parmesan cheese.",
                "Toss with Caesar dressing.",
                "Top with sliced chicken.",
                "Serve immediately."
            ));
        }});
        put("Chili Con Carne", new HashMap<>() {{
            put("ingredients", java.util.Arrays.asList(
                "Ground beef: 500g", 
                "Kidney beans: 1 can", 
                "Tomato sauce: 2 cups", 
                "Onion: 1", 
                "Garlic: 2 cloves", 
                "Chili powder: 2 tablespoons"
            ));
            put("steps", java.util.Arrays.asList(
                "Heat oil in a large pot over medium heat.",
                "Add chopped onion and garlic, sauté until translucent.",
                "Add ground beef, cook until browned.",
                "Stir in kidney beans, tomato sauce, and chili powder.",
                "Simmer for 20 minutes.",
                "Serve hot."
            ));
        }});
        put("Omelette", new HashMap<>() {{
            put("ingredients", java.util.Arrays.asList(
                "Eggs: 3", 
                "Milk: 1/4 cup", 
                "Salt: 1/2 teaspoon", 
                "Pepper: 1/4 teaspoon", 
                "Cheese: 1/2 cup", 
                "Ham: 1/2 cup"
            ));
            put("steps", java.util.Arrays.asList(
                "Whisk eggs, milk, salt, and pepper in a bowl.",
                "Heat a skillet over medium heat, pour in the egg mixture.",
                "Cook until edges start to set, add cheese and ham.",
                "Fold the omelette in half, cook until cheese melts.",
                "Serve hot."
            ));
        }});
    }};

    private JComboBox<String> recipeDropdown;
    private JTextArea ingredientsArea;
    private JTextArea stepsArea;
    private JTextField newRecipeField;
    private JButton addRecipeButton;
    private JButton viewRecipeButton;

    /**
     * Constructor for RecipePanel, initializes the panel components and layout.
     */
    public RecipePanel() {
        setLayout(new BorderLayout());

        recipes = new HashMap<>(predefinedRecipes);

        recipeDropdown = new JComboBox<>(recipes.keySet().toArray(new String[0]));
        ingredientsArea = new JTextArea(10, 20);
        stepsArea = new JTextArea(10, 20);
        newRecipeField = new JTextField(20);
        addRecipeButton = new JButton("Add New Recipe");
        viewRecipeButton = new JButton("View Recipe");

        JPanel topPanel = new JPanel();
        topPanel.add(recipeDropdown);
        topPanel.add(viewRecipeButton);

        JPanel newRecipePanel = new JPanel();
        newRecipePanel.add(new JLabel("New Recipe Name:"));
        newRecipePanel.add(newRecipeField);
        newRecipePanel.add(addRecipeButton);

        add(topPanel, BorderLayout.NORTH);
        add(new JScrollPane(ingredientsArea), BorderLayout.WEST);
        add(new JScrollPane(stepsArea), BorderLayout.CENTER);
        add(newRecipePanel, BorderLayout.SOUTH);

        viewRecipeButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String recipeName = (String) recipeDropdown.getSelectedItem();
                List<String> ingredients = recipes.get(recipeName).get("ingredients");
                List<String> steps = recipes.get(recipeName).get("steps");

                ingredientsArea.setText("Ingredients:\n" + String.join("\n", ingredients));
                stepsArea.setText("Steps:\n" + String.join("\n", steps));
            }
        });

        addRecipeButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String newRecipeName = newRecipeField.getText();
                if (!newRecipeName.isEmpty() && !recipes.containsKey(newRecipeName)) {
                    recipes.put(newRecipeName, new HashMap<>() {{
                        put("ingredients", new java.util.ArrayList<>());
                        put("steps", new java.util.ArrayList<>());
                    }});
                    recipeDropdown.addItem(newRecipeName);
                    newRecipeField.setText("");
                }
            }
        });
    }

    /**
     * Loads a recipe into the text areas for viewing.
     * @param recipeName The name of the recipe to load.
     */
    public void loadRecipe(String recipeName) {
        List<String> ingredients = recipes.get(recipeName).get("ingredients");
        List<String> steps = recipes.get(recipeName).get("steps");

        ingredientsArea.setText("Ingredients:\n" + String.join("\n", ingredients));
        stepsArea.setText("Steps:\n" + String.join("\n", steps));
    }

    /**
     * @return The ingredients area text component.
     */
    public JTextArea getIngredientsArea() {
        return ingredientsArea;
    }

    /**
     * @return The steps area text component.
     */
    public JTextArea getStepsArea() {
        return stepsArea;
    }
}
