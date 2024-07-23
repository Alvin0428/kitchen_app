package kitchen;

import javax.swing.*;

public class Main {
    public static void main(String[] args) {
        SwingUtilities.invokeLater(new Runnable() {
            @Override
            public void run() {
                JFrame frame = new JFrame("Kitchen Application");
                frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
                frame.setSize(800, 600);

                JTabbedPane tabbedPane = new JTabbedPane();

                // Add RecipePanel
                RecipePanel recipePanel = new RecipePanel();
                tabbedPane.addTab("Recipes", recipePanel);

                // Add TimerPanel
                TimerPanel timerPanel = new TimerPanel();
                tabbedPane.addTab("Timers", timerPanel);

                // Add UnitConverterPanel
                UnitConverterPanel unitConverterPanel = new UnitConverterPanel();
                tabbedPane.addTab("Unit Converter", unitConverterPanel);

                frame.add(tabbedPane);
                frame.setVisible(true);
            }
        });
    }
}
