package kitchen;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.util.List;

public class IngredientsAndStepsPanel extends JPanel {
    private JTextField ingredientField;
    private JTextField measurementField;
    private JTextArea ingredientsList;
    private JTextField stepField;
    private JTextArea stepsList;
    private List<String> customIngredients = new ArrayList<>();
    private List<String> customSteps = new ArrayList<>();

    public IngredientsAndStepsPanel() {
        setLayout(new BorderLayout());

        ingredientField = new JTextField(20);
        measurementField = new JTextField(20);
        ingredientsList = new JTextArea(10, 30);
        ingredientsList.setEditable(false);
        stepField = new JTextField(20);
        stepsList = new JTextArea(10, 30);
        stepsList.setEditable(false);

        JPanel inputPanel = new JPanel();
        inputPanel.setLayout(new FlowLayout());
        inputPanel.add(new JLabel("Ingredient:"));
        inputPanel.add(ingredientField);
        inputPanel.add(new JLabel("Measurement:"));
        inputPanel.add(measurementField);
        JButton addIngredientButton = new JButton("Add Ingredient");
        addIngredientButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                addIngredient();
            }
        });
        inputPanel.add(addIngredientButton);

        JPanel stepPanel = new JPanel();
        stepPanel.setLayout(new FlowLayout());
        stepPanel.add(new JLabel("Step:"));
        stepPanel.add(stepField);
        JButton addStepButton = new JButton("Add Step");
        addStepButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                addStep();
            }
        });
        stepPanel.add(addStepButton);

        add(inputPanel, BorderLayout.NORTH);
        add(new JScrollPane(ingredientsList), BorderLayout.CENTER);
        add(stepPanel, BorderLayout.SOUTH);
        add(new JScrollPane(stepsList), BorderLayout.EAST);
    }

    private void addIngredient() {
        String ingredient = ingredientField.getText();
        String measurement = measurementField.getText();
        if (!ingredient.isEmpty() && !measurement.isEmpty()) {
            customIngredients.add(ingredient + ": " + measurement);
            ingredientsList.append(ingredient + ": " + measurement + "\n");
            ingredientField.setText("");
            measurementField.setText("");
        }
    }

    private void addStep() {
        String step = stepField.getText();
        if (!step.isEmpty()) {
            customSteps.add(step);
            stepsList.append(step + "\n");
            stepField.setText("");
        }
    }
}
