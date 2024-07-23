package kitchen;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

import org.junit.jupiter.api.Test;

/**
 * This test suite contains tests for the CustomTimer logic.
 * Each test verifies the correctness of timer operations.
 */
public class CustomTimerTest {

    @Test
    public void testAddTimerWithValidDuration() {
        CustomTimer timer = new CustomTimer("Test Timer", 1, 30, 0);
        assertEquals(1, timer.getHours());
        assertEquals(30, timer.getMinutes());
        assertEquals(0, timer.getSeconds());
    }

    @Test
    public void testAddTimerWithNegativeHours() {
        assertThrows(IllegalArgumentException.class, () -> {
            new CustomTimer("Test Timer", -1, 30, 0);
        });
    }

    @Test
    public void testAddTimerWithNegativeMinutes() {
        assertThrows(IllegalArgumentException.class, () -> {
            new CustomTimer("Test Timer", 1, -30, 0);
        });
    }

    @Test
    public void testAddTimerWithNegativeSeconds() {
        assertThrows(IllegalArgumentException.class, () -> {
            new CustomTimer("Test Timer", 1, 30, -10);
        });
    }

    @Test
    public void testStartTimer() {
        CustomTimer timer = new CustomTimer("Test Timer", 0, 1, 0);
        timer.start();
        assertEquals(CustomTimer.TimerStatus.RUNNING, timer.getStatus());
    }

    @Test
    public void testStopTimer() {
        CustomTimer timer = new CustomTimer("Test Timer", 0, 1, 0);
        timer.start();
        timer.stop();
        assertEquals(CustomTimer.TimerStatus.STOPPED, timer.getStatus());
    }

    @Test
    public void testResetTimer() {
        CustomTimer timer = new CustomTimer("Test Timer", 0, 1, 0);
        timer.start();
        timer.reset();
        assertEquals(0, timer.getHours());
        assertEquals(1, timer.getMinutes());
        assertEquals(0, timer.getSeconds());
        assertEquals(CustomTimer.TimerStatus.RESET, timer.getStatus());
    }
}
