create database trigg;
use trigg;

-- Create MATCCH table  SINCE MATCH IS A KEYWORD
CREATE TABLE MATCCH (
    Day INT,
    HomeTeam VARCHAR(50),
    AwayTeam VARCHAR(50),
    HomeGoal INT,
    AwayGoal INT
);
-- Create STANDING table
CREATE TABLE STANDING (
    Day INT,
    Team VARCHAR(50),
    Score INT DEFAULT 0
);
select*from MATCCH;
select*from STANDING;
truncate table matcch;
truncate table standing;
SET SQL_SAFE_UPDATES = 0; 
DROP TRIGGER IF EXISTS home_trigger;
DROP TRIGGER IF EXISTS away_trigger;
DROP TRIGGER IF EXISTS tie_trigger;

DELIMITER //
-- Trigger for Home Team Victory
CREATE TRIGGER home_trigger
AFTER INSERT ON MATCCH
FOR EACH ROW
BEGIN
    IF NEW.HomeGoal > NEW.AwayGoal THEN
   -- Check if the HomeTeam exists in the STANDING table
    IF NOT EXISTS (SELECT 1 FROM STANDING WHERE Day = NEW.Day AND Team = NEW.HomeTeam) THEN
        -- If the HomeTeam doesn't exist, insert it into the STANDING table with a score of 3
        INSERT INTO STANDING (Day, Team, Score) VALUES (NEW.Day, NEW.HomeTeam, 3);
    ELSE
        -- Otherwise, update the score by 3
        UPDATE STANDING
        SET Score = Score + 3
        WHERE Day = NEW.Day AND Team = NEW.HomeTeam;
    END IF;
        END IF;
END;
// DELIMITER ;

DELIMITER //
-- Trigger for Away Team Victory
CREATE TRIGGER away_trigger
AFTER INSERT ON MATCCH
FOR EACH ROW
BEGIN
    IF NEW.AwayGoal > NEW.HomeGoal THEN
        -- Check if the AwayTeam exists in the STANDING table
        IF NOT EXISTS (SELECT 1 FROM STANDING WHERE Day = NEW.Day AND Team = NEW.AwayTeam) THEN
            -- If the AwayTeam doesn't exist, insert it into the STANDING table with a score of 3
            INSERT INTO STANDING (Day, Team, Score) VALUES (NEW.Day, NEW.AwayTeam, 3);
        ELSE
            -- Otherwise, update the score by 3
            UPDATE STANDING
            SET Score = Score + 3
            WHERE Day = NEW.Day AND Team = NEW.AwayTeam;
        END IF;
    END IF;
END;
// DELIMITER ;

DELIMITER //
-- Trigger for Tie
CREATE TRIGGER tie_trigger
AFTER INSERT ON MATCCH
FOR EACH ROW
BEGIN
    IF NEW.HomeGoal = NEW.AwayGoal THEN
        -- Check if the HomeTeam exists in the STANDING table
        IF NOT EXISTS (SELECT 1 FROM STANDING WHERE Day = NEW.Day AND Team = NEW.HomeTeam) THEN
            -- If the HomeTeam doesn't exist, insert it into the STANDING table with a score of 1
            INSERT INTO STANDING (Day, Team, Score) VALUES (NEW.Day, NEW.HomeTeam, 1);
        ELSE
            -- Otherwise, update the score by 1
            UPDATE STANDING
            SET Score = Score + 1
            WHERE Day = NEW.Day AND Team = NEW.HomeTeam;
        END IF;

        -- Check if the AwayTeam exists in the STANDING table
        IF NOT EXISTS (SELECT 1 FROM STANDING WHERE Day = NEW.Day AND Team = NEW.AwayTeam) THEN
            -- If the AwayTeam doesn't exist, insert it into the STANDING table with a score of 1
            INSERT INTO STANDING (Day, Team, Score) VALUES (NEW.Day, NEW.AwayTeam, 1);
        ELSE
            -- Otherwise, update the score by 1
            UPDATE STANDING
            SET Score = Score + 1
            WHERE Day = NEW.Day AND Team = NEW.AwayTeam;
        END IF;
    END IF;
END;
// DELIMITER ;

-- Insert sample data into MATCCH table
INSERT INTO MATCCH (Day, HomeTeam, AwayTeam, HomeGoal, AwayGoal) VALUES
(1, 'TeamA', 'TeamB', 2, 1),
(1, 'TeamC', 'TeamD', 1, 2),
(1, 'TeamD', 'TeamA', 1, 2),
(2, 'TeamB', 'TeamA', 3, 5),
(2, 'TeamB', 'TeamC', 3, 3),
(1, 'TeamF', 'TeamE', 2, 1),
(1, 'TeamC', 'TeamG', 1, 2),
(1, 'TeamH', 'TeamF', 1, 2),
(2, 'TeamD', 'TeamA', 3, 5),
(2, 'TeamK', 'TeamC', 3, 3);






