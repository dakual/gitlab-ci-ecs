import unittest, json
from run import app

class TestApi(unittest.TestCase):

    def setUp(self):
        self.app = app.test_client()

    def tearDown(self):
        pass
    
    def test_api(self):
        response = self.app.get("/")

        self.assertEqual(200, response.status_code)
        self.assertEqual("application/json", response.headers["Content-Type"])

        resp_payload = json.loads(response.data)
        self.assertLessEqual(0, resp_payload["data"]["cpu"])
        self.assertLessEqual(0, resp_payload["data"]["disk"])
        self.assertLessEqual(0, resp_payload["data"]["mem"])


if __name__ == '__main__':
    unittest.main()