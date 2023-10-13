-- creates a stored procedure ComputeAverageWeightedScoreForUser
-- that computes and store the average weighted score for a student

DELIMITER $$ ;
CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INT)
BEGIN
    DECLARE weight_factor INT;
    DECLARE number_x_weight_factor INT;

    SELECT SUM(projects.weight) INTO weight_factor FROM projects
    INNER JOIN corrections ON corrections.project_id=projects.id
    WHERE corrections.user_id=user_id;

    SELECT SUM(projects.weight * corrections.score) INTO number_x_weight_factor FROM corrections
    INNER JOIN projects ON projects.id=corrections.project_id
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
