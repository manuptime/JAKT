import models

import unittest


class TestTriviaModels(unittest.TestCase):

    def setUp(self):
        self.a = models.Answer(answer="bad gps", correct=True)
        self.q = models.Question(answers=[self.a], copy="What caused the problem")

    def test_question_validates(self):
        self.assertTrue(self.q.validate())

    def test_answer_validates(self):
        self.assertTrue(self.a.validate())


if __name__ == '__main__':
    unittest.main()
