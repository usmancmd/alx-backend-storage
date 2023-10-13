-- creates a stored procedure ComputeAverageWeightedScoreForUser
-- that computes and store the average weighted score for a student

DELIMITER $$ ;
CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INT)
BEGIN
    DECLARE weight_factor INT;
    DECLARE number_x_weight_factor INT;

    SELECT SUM(project_id) INTO weight_factor FROM corrections
    WHERE corrections.user_id=user_id;

    SELECT SUM(project_id * score) INTO number_x_weight_factor FROM corrections
    WHERE corrections.user_id=user_id;

    IF number_x_weight_factor = 0 THEN
        UPDATE users
        SET average_score = 0
        WHERE users.id=user_id;
    ELSE
        UPDATE users
        SET average_score = number_x_weight_factor / weight_factor
        WHERE users.id=user_id;
    END IF;
END$$
DELIMITER ; $$
