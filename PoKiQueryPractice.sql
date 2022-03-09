--1. What grades are stored in the database?
SELECT * FROM Grade

--2. What emotions may be associated with a poem?
SELECT * FROM Emotion

--3. How many poems are in the database?
SELECT Count(Poem.Id) 'Number of Poems'
FROM Poem

--4. Sort authors alphabetically by name. What are the names of the top 76 authors?
SELECT TOP 76 Author.Name
FROM Author
ORDER BY Author.Name

--5. Starting with the above query, add the grade of each of the authors.

SELECT TOP 76 Author.Name, Grade.Name Grade
FROM Author
JOIN Grade ON Grade.Id = Author.GradeId
ORDER BY Author.Name

--6. Starting with the above query, add the recorded gender of each of the authors.
SELECT TOP 76 Author.Name, Grade.Name, Gender.Name
FROM Author
JOIN Grade ON Grade.Id = Author.GradeId
JOIN Gender ON Gender.Id =  Author.GenderId
ORDER BY Author.Name


--7. What is the total number of words in all poems in the database?
Select Sum(Poem.WordCount) 'Total Word Count'
From Poem

--8. Which poem has the fewest characters?
SELECT TOP 1 Poem.Title 'Poem Title', Poem.CharCount
FROM Poem
ORDER BY Poem.CharCount 

--9. How many authors are in the third grade?
SELECT Count(Author.Id) ' Number of authors in third grade'
FROM Author
JOIN Grade ON Grade.Id= Author.GradeId
WHERE Grade.Name = '3rd Grade'

--10. How many total authors are in the first through third grades?
SELECT Count(Author.Id) ' Number of authors in first through third grade'
FROM Author
LEFT JOIN Grade ON Grade.Id= Author.GradeId
WHERE Grade.Name = '3rd Grade' OR Grade.Name = '2nd Grade' OR Grade.Name ='1st Grade'

--11. What is the total number of poems written by fourth graders?
Select COUNT(Poem.Id) 'Total number of Poems written by fourth graders'
From Poem
JOIN Author ON Poem.AuthorId = Author.Id
JOIN Grade ON Author.GradeId = Grade.Id
WHERE Grade.Name = '4th Grade'

--12. How many poems are there per grade?
SELECT Grade.Name, COUNT(Poem.Id) 'Total number of Poems written by each grade'
FROM Poem
JOIN Author ON Poem.AuthorId = Author.Id
JOIN Grade ON Author.GradeId = Grade.Id
GROUP BY Grade.Id, Grade.Name
ORDER BY Grade.Id 

--13. How many authors are in each grade? (Order your results by grade starting with 1st Grade)
SELECT Grade.Name 'Grade', Count(Author.Id) 'Number of authors in each grade'
FROM Author
JOIN Grade ON Grade.Id= Author.GradeId
GROUP BY Grade.Id, Grade.Name
ORDER BY Grade.Id 

--14. What is the title of the poem that has the most words?
SELECT TOP 1 Poem.Title 'Poem Title', Poem.WordCount 'Word Count'
FROM Poem
ORDER BY Poem.WordCount DESC

--15. Which author(s) have the most poems? (Remember authors can have the same name.)
SELECT TOP 10 Author.Name, Count(Poem.AuthorId) 'Number of Poems'
FROM Poem
JOIN Author ON Author.Id = Poem.AuthorId
GROUP BY Author.Id, Author.Name
ORDER BY Count(Poem.AuthorId) DESC

--16. How many poems have an emotion of sadness?
SELECT Count(PoemEmotion.EmotionId) 'Number of Poems with Emotion of Sadness'
FROM PoemEmotion
JOIN Emotion ON PoemEmotion.EmotionId = Emotion.Id
WHERE Emotion.Name = 'Joy'

--17. How many poems are not associated with any emotion?
SELECT Count(Poem.Id) 'Number of Poems with no Emotion'
FROM Poem
LEFT JOIN PoemEmotion ON PoemEmotion.PoemId = Poem.Id
WHERE PoemEmotion.EmotionId is NULL



--18. Which emotion is associated with the least number of poems?
SELECT TOP 1 Emotion.Name Emotion, Count(Poem.Id) 'Number of Poems'
FROM Poem
JOIN PoemEmotion ON PoemEmotion.PoemId = Poem.Id
JOIN Emotion ON Emotion.Id = PoemEmotion.EmotionId
GROUP BY Emotion.Name
ORDER BY Count(Poem.Id)


--19. Which grade has the largest number of poems with an emotion of joy?
SELECT TOP 1 Grade.Name 'Grade', Count(Poem.Id) 'Number of Poems'
FROM Grade
JOIN Author ON Author.GradeId = Grade.Id
JOIN Poem ON Poem.AuthorId = Author.Id
JOIN PoemEmotion ON PoemEmotion.PoemId = Poem.Id
JOIN Emotion ON Emotion.Id = PoemEmotion.EmotionId
WHERE Emotion.Name = 'Joy'
GROUP BY Grade.Id, Grade.Name
ORDER BY Count(Poem.Id) DESC

--20. Which gender has the least number of poems with an emotion of fear?
SELECT TOP 1 Gender.Name 'Gender', Count(Poem.Id) 'Number of Poems'
FROM Gender
JOIN Author ON Author.GenderId = Gender.Id
JOIN Poem ON Poem.AuthorId = Author.Id
JOIN PoemEmotion ON PoemEmotion.PoemId = Poem.Id
JOIN Emotion ON Emotion.Id = PoemEmotion.EmotionId
WHERE Emotion.Name = 'Fear'
GROUP BY Gender.Id, Gender.Name
ORDER BY Count(Poem.Id)

