package kitchen;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JOptionPane;
import javax.swing.Timer;

/**
 * CustomTimer class represents a countdown timer with a specified name, hours, minutes, and seconds.
 * It uses a Swing Timer to handle the countdown and updates the remaining time every second.
 */
public class CustomTimer {
    private String name;
    private int hours;
    private int minutes;
    private int seconds;
    private int remainingTime;
    private Timer swingTimer;
    private TimerStatus status;

    /**
     * Constructs a CustomTimer object with the specified name, hours, minutes, and seconds.
     * Initializes the remaining time and sets up the Swing Timer to decrement the remaining time.
     *
     * @param name     the name of the timer
     * @param hours    the initial hours
     * @param minutes  the initial minutes
     * @param seconds  the initial seconds
     */
    public CustomTimer(String name, int hours, int minutes, int seconds) {
        if (hours < 0 || minutes < 0 || seconds < 0) {
            throw new IllegalArgumentException("Time values must be non-negative");
        }

        this.name = name;
        this.hours = hours;
        this.minutes = minutes;
        this.seconds = seconds;
        this.remainingTime = (hours * 3600) + (minutes * 60) + seconds;
        this.status = TimerStatus.RESET;

        // Initialize the Swing Timer to decrement the remaining time every second
        this.swingTimer = new Timer(1000, new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if (remainingTime > 0) {
                    remainingTime--;
                } else {
                    swingTimer.stop();
                    status = TimerStatus.FINISHED;
                    JOptionPane.showMessageDialog(null, name + " timer has ended!");
                }
            }
        });
    }

    /**
     * Returns the name of the timer.
     *
     * @return the name of the timer
     */
    public String getName() {
        return name;
    }

    /**
     * Returns the remaining time formatted as HH:mm:ss.
     *
     * @return the formatted remaining time
     */
    public String getFormattedTime() {
        int h = remainingTime / 3600;
        int m = (remainingTime % 3600) / 60;
        int s = remainingTime % 60;
        return String.format("%02d:%02d:%02d", h, m, s);
    }

    /**
     * Starts the countdown timer.
     */
    public void start() {
        swingTimer.start();
        status = TimerStatus.RUNNING;
    }

    /**
     * Stops the countdown timer.
     */
    public void stop() {
        swingTimer.stop();
        status = TimerStatus.STOPPED;
    }

    /**
     * Resets the timer to its initial time.
     */
    public void reset() {
        this.remainingTime = (hours * 3600) + (minutes * 60) + seconds;
        this.status = TimerStatus.RESET;
    }

    /**
     * Returns the current status of the timer.
     *
     * @return the status of the timer
     */
    public TimerStatus getStatus() {
        return status;
    }

    /**
     * Returns the initial hours of the timer.
     *
     * @return the initial hours of the timer
     */
    public int getHours() {
        return hours;
    }

    /**
     * Returns the initial minutes of the timer.
     *
     * @return the initial minutes of the timer
     */
    public int getMinutes() {
        return minutes;
    }

    /**
     * Returns the initial seconds of the timer.
     *
     * @return the initial seconds of the timer
     */
    public int getSeconds() {
        return seconds;
    }

    /**
     * Enum representing the possible statuses of the timer.
     */
    public enum TimerStatus {
        RUNNING,
        STOPPED,
        RESET,
        FINISHED
    }
}
