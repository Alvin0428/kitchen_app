package kitchen;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.util.List;

/**
 * TimerPanel class creates a panel for adding and managing countdown timers.
 * Users can input timer name, hours, minutes, and seconds. The timer counts down and alerts the user when it ends.
 */
public class TimerPanel extends JPanel {
    private JTextField nameField;
    private JTextField hoursField;
    private JTextField minutesField;
    private JTextField secondsField;
    private JTextArea resultArea;
    private JButton addTimerButton;
    private List<CustomTimer> timers;

    /**
     * Constructor for TimerPanel, initializes the panel components and layout.
     */
    public TimerPanel() {
        timers = new ArrayList<>();
        setLayout(new BorderLayout());

        JPanel inputPanel = new JPanel();
        inputPanel.setLayout(new GridLayout(5, 2));

        inputPanel.add(new JLabel("Timer Name:"));
        nameField = new JTextField(10);
        inputPanel.add(nameField);

        inputPanel.add(new JLabel("Hours:"));
        hoursField = new JTextField(10);
        inputPanel.add(hoursField);

        inputPanel.add(new JLabel("Minutes:"));
        minutesField = new JTextField(10);
        inputPanel.add(minutesField);

        inputPanel.add(new JLabel("Seconds:"));
        secondsField = new JTextField(10);
        inputPanel.add(secondsField);

        addTimerButton = new JButton("Add Timer");
        addTimerButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    String name = nameField.getText();
                    int hours = Integer.parseInt(hoursField.getText());
                    int minutes = Integer.parseInt(minutesField.getText());
                    int seconds = Integer.parseInt(secondsField.getText());

                    if (hours < 0 || minutes < 0 || seconds < 0) {
                        throw new NumberFormatException();
                    }

                    CustomTimer timer = new CustomTimer(name, hours, minutes, seconds);
                    timers.add(timer);
                    timer.start();
                    resultArea.append("Added Timer: " + timer.getName() + " (" + timer.getFormattedTime() + ")\n");
                } catch (NumberFormatException ex) {
                    resultArea.append("Invalid time entered. Please enter positive values for hours, minutes, and seconds.\n");
                }
            }
        });
        inputPanel.add(addTimerButton);

        resultArea = new JTextArea(10, 30);
        resultArea.setEditable(false);

        add(inputPanel, BorderLayout.NORTH);
        add(new JScrollPane(resultArea), BorderLayout.CENTER);
    }

    /**
     * Inner class CustomTimer representing a custom countdown timer.
     */
    private class CustomTimer {
        private String name;
        private TimerState state;
        private javax.swing.Timer timer;

        /**
         * Constructor for CustomTimer.
         *
         * @param name    Timer name.
         * @param hours   Initial hours.
         * @param minutes Initial minutes.
         * @param seconds Initial seconds.
         */
        public CustomTimer(String name, int hours, int minutes, int seconds) {
            this.name = name;
            this.state = new TimerState(hours, minutes, seconds);
            this.timer = new javax.swing.Timer(1000, new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {
                    if (state.seconds > 0) {
                        state.seconds--;
                    } else if (state.minutes > 0) {
                        state.minutes--;
                        state.seconds = 59;
                    } else if (state.hours > 0) {
                        state.hours--;
                        state.minutes = 59;
                        state.seconds = 59;
                    } else {
                        timer.stop();
                        JOptionPane.showMessageDialog(TimerPanel.this, name + " timer finished!");
                    }
                    updateResultArea();
                }
            });
        }

        /**
         * Starts the timer.
         */
        public void start() {
            timer.start();
        }

        /**
         * Gets the name of the timer.
         *
         * @return Timer name.
         */
        public String getName() {
            return name;
        }

        /**
         * Gets the formatted time left for the timer.
         *
         * @return Formatted time string.
         */
        public String getFormattedTime() {
            return String.format("%02d:%02d:%02d", state.hours, state.minutes, state.seconds);
        }

        /**
         * Updates the result area with the current timer state.
         */
        private void updateResultArea() {
            resultArea.append("Timer " + name + " - Time Left: " + getFormattedTime() + "\n");
        }
    }

    /**
     * Inner class TimerState representing the state of the timer.
     */
    private class TimerState {
        private int hours;
        private int minutes;
        private int seconds;

        /**
         * Constructor for TimerState.
         *
         * @param hours   Initial hours.
         * @param minutes Initial minutes.
         * @param seconds Initial seconds.
         */
        public TimerState(int hours, int minutes, int seconds) {
            this.hours = hours;
            this.minutes = minutes;
            this.seconds = seconds;
        }
    }
}
