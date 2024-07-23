package kitchen;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.HashMap;
import java.util.Map;

/**
 * UnitConverterPanel class creates a panel for converting units of measurement.
 * It supports conversions between various units like cups, tablespoons, teaspoons, kilograms, grams, milligrams, liters, milliliters, ounces, pounds, and quarts.
 */
public class UnitConverterPanel extends JPanel {
    private JTextField inputField;
    private JComboBox<String> fromUnit;
    private JComboBox<String> toUnit;
    private JLabel resultLabel;

    /**
     * A map containing conversion rates between various units.
     */
    private static final Map<String, Map<String, Double>> conversionRates = new HashMap<>() {{
        put("cup", new HashMap<>() {{
            put("cup", 1.0);
            put("tablespoon", 16.0);
            put("teaspoon", 48.0);
            put("kg", 0.24);
            put("g", 240.0);
            put("mg", 240000.0);
            put("l", 0.24);
            put("ml", 240.0);
            put("oz", 8.0);
            put("lb", 0.5);
            put("qt", 0.25);
        }});
        put("tablespoon", new HashMap<>() {{
            put("cup", 0.0625);
            put("tablespoon", 1.0);
            put("teaspoon", 3.0);
            put("kg", 0.015);
            put("g", 15.0);
            put("mg", 15000.0);
            put("l", 0.015);
            put("ml", 15.0);
            put("oz", 0.5);
            put("lb", 0.03125);
            put("qt", 0.015625);
        }});
        put("teaspoon", new HashMap<>() {{
            put("cup", 0.0208333);
            put("tablespoon", 0.333333);
            put("teaspoon", 1.0);
            put("kg", 0.005);
            put("g", 5.0);
            put("mg", 5000.0);
            put("l", 0.005);
            put("ml", 5.0);
            put("oz", 0.166667);
            put("lb", 0.0104167);
            put("qt", 0.00520833);
        }});
        put("kg", new HashMap<>() {{
            put("cup", 4.16667);
            put("tablespoon", 66.6667);
            put("teaspoon", 200.0);
            put("kg", 1.0);
            put("g", 1000.0);
            put("mg", 1000000.0);
            put("l", 1.0);
            put("ml", 1000.0);
            put("oz", 35.274);
            put("lb", 2.20462);
            put("qt", 1.05669);
        }});
        put("g", new HashMap<>() {{
            put("cup", 0.00416667);
            put("tablespoon", 0.0666667);
            put("teaspoon", 0.2);
            put("kg", 0.001);
            put("g", 1.0);
            put("mg", 1000.0);
            put("l", 0.001);
            put("ml", 1.0);
            put("oz", 0.035274);
            put("lb", 0.00220462);
            put("qt", 0.00105669);
        }});
        put("mg", new HashMap<>() {{
            put("cup", 0.00000416667);
            put("tablespoon", 0.0000666667);
            put("teaspoon", 0.0002);
            put("kg", 0.000001);
            put("g", 0.001);
            put("mg", 1.0);
            put("l", 0.000001);
            put("ml", 0.001);
            put("oz", 0.000035274);
            put("lb", 0.00000220462);
            put("qt", 0.00000105669);
        }});
        put("l", new HashMap<>() {{
            put("cup", 4.16667);
            put("tablespoon", 66.6667);
            put("teaspoon", 200.0);
            put("kg", 1.0);
            put("g", 1000.0);
            put("mg", 1000000.0);
            put("l", 1.0);
            put("ml", 1000.0);
            put("oz", 33.814);
            put("lb", 2.20462);
            put("qt", 1.05669);
        }});
        put("ml", new HashMap<>() {{
            put("cup", 0.00416667);
            put("tablespoon", 0.0666667);
            put("teaspoon", 0.2);
            put("kg", 0.001);
            put("g", 1.0);
            put("mg", 1000.0);
            put("l", 0.001);
            put("ml", 1.0);
            put("oz", 0.033814);
            put("lb", 0.00220462);
            put("qt", 0.00105669);
        }});
        put("oz", new HashMap<>() {{
            put("cup", 0.125);
            put("tablespoon", 2.0);
            put("teaspoon", 6.0);
            put("kg", 0.0283495);
            put("g", 28.3495);
            put("mg", 28349.5);
            put("l", 0.0295735);
            put("ml", 29.5735);
            put("oz", 1.0);
            put("lb", 0.0625);
            put("qt", 0.03125);
        }});
        put("lb", new HashMap<>() {{
            put("cup", 2.0);
            put("tablespoon", 32.0);
            put("teaspoon", 96.0);
            put("kg", 0.453592);
            put("g", 453.592);
            put("mg", 453592.0);
            put("l", 0.453592);
            put("ml", 453.592);
            put("oz", 16.0);
            put("lb", 1.0);
            put("qt", 0.5);
        }});
        put("qt", new HashMap<>() {{
            put("cup", 4.0);
            put("tablespoon", 64.0);
            put("teaspoon", 192.0);
            put("kg", 0.946353);
            put("g", 946.353);
            put("mg", 946353.0);
            put("l", 0.946353);
            put("ml", 946.353);
            put("oz", 32.0);
            put("lb", 2.0);
            put("qt", 1.0);
        }});
    }};

    /**
     * Constructor for UnitConverterPanel, initializes the panel components and layout.
     */
    public UnitConverterPanel() {
        setLayout(new BorderLayout());

        inputField = new JTextField(10);
        fromUnit = new JComboBox<>(conversionRates.keySet().toArray(new String[0]));
        toUnit = new JComboBox<>(conversionRates.keySet().toArray(new String[0]));
        resultLabel = new JLabel("Result: ");

        JButton convertButton = new JButton("Convert");
        convertButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                convert();
            }
        });

        JPanel panel = new JPanel();
        panel.add(inputField);
        panel.add(fromUnit);
        panel.add(new JLabel("to"));
        panel.add(toUnit);
        panel.add(convertButton);

        add(panel, BorderLayout.NORTH);
        add(resultLabel, BorderLayout.CENTER);
    }

    /**
     * Converts the given value from one unit to another and updates the result label.
     */
    private void convert() {
        try {
            double value = Double.parseDouble(inputField.getText());
            String from = (String) fromUnit.getSelectedItem();
            String to = (String) toUnit.getSelectedItem();
            double convertedValue = convert(from, to, value);
            resultLabel.setText("Result: " + value + " " + from + " = " + convertedValue + " " + to);
        } catch (NumberFormatException e) {
            resultLabel.setText("Please enter a valid number");
        }
    }

    /**
     * Performs the unit conversion based on the specified conversion rates.
     *
     * @param from  The unit to convert from.
     * @param to    The unit to convert to.
     * @param value The value to convert.
     * @return The converted value.
     */
    public double convert(String from, String to, double value) {
        return value * conversionRates.get(from).get(to);
    }
}
