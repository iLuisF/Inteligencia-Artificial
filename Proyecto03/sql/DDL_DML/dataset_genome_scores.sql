CREATE TABLE dataset.genome_scores
(
    movieId bigint(20),
    tagId bigint(20),
    relevance decimal(18,18),
    CONSTRAINT genome_scores_ibfk_1 FOREIGN KEY (movieId) REFERENCES movies (movieId)
);
CREATE INDEX movieId ON dataset.genome_scores (movieId);