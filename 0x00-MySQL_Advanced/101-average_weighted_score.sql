-- creates a stored procedure ComputeAverageWeightedScoreForUsers
-- that computes and store the average weighted score for all students 

DELIMITER $$ ;
CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    ALTER TABLE users ADD weight_factor INT NOT NULL;
    ALTER TABLE users ADD number_x_weight_factor INT NOT NULL;

    UPDATE users
    SET weight_factor = (
        SELECT SUM(projects.weight) FROM projects
        INNER JOIN corrections ON corrections.project_id=projects.id
        WHERE corrections.user_id=users.id
    );

    UPDATE users
    SET number_x_weight_factor = (
        SELECT SUM(projects.weight * corrections.score) FROM corrections
        INNER JOIN projects ON projects.id=corrections.project_id
        WHERE corrections.user_id=users.id
    );

    UPDATE users
        SET users.average_score = IF(users.weight_factor = 0, 0, users.number_x_weight_factor / users.weight_factor);
    ALTER TABLE users
        DROP COLUMN number_x_weight_factor;
    ALTER TABLE users
        DROP COLUMN weight_factor;
END$$
DELIMITER ; $$
