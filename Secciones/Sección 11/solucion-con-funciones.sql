SELECT c.*, (
        select json_agg(
                json_build_object(
                    'user', c2.user_id, 'comment', c2.content
                )
            )
        from comments c2
        where
            c2.comment_parent_id = c.comment_id
    ) AS replies
FROM comments c
WHERE
    c.comment_parent_id IS NULL;

CREATE OR REPLACE FUNCTION comments_replies(id INTEGER)
RETURNS json
AS $$
DECLARE
    result json;
BEGIN

    SELECT json_agg(json_build_object('user', user_id, 'comment', content))
            INTO result
            FROM comments
            WHERE comment_parent_id = id;

    RETURN result;
END;
$$ LANGUAGE plpgsql;

SELECT
    c.*,
    comments_replies(c.comment_id) AS replies
FROM comments c
WHERE c.comment_parent_id IS NULL;