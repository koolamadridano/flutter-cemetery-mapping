const express = require("express");
const router = express.Router();

const burialController = require("../controllers/burialController");

// [POST] api/burial
// @Description: CREATE burial
router.post("/burial", (req, res) => {
    burialController.createBurialData(req, res);
});

// [GET] api/burial
// @Description: GET burial data
router.get("/burial", (req, res) => {
    burialController.getBurialData(req, res);
});

// [GET] api/burial/all
// @Description: GET all burial data
router.get("/burial/all", (req, res) => {
    burialController.getAllBurialData(req, res);
});

// [PUT] api/burial/update-movant
// @Description: UPDATE movant data
router.put("/burial/update-movant", (req, res) => {
    burialController.updateMovantData(req, res);
});

// [PUT] api/burial/update-registrant
// @Description: UPDATE registrant data
router.put("/burial/update-registrant", (req, res) => {
    burialController.updateRegistrantData(req, res);
});

// [DELETE] api/burial/<622790a3fafa7923e4c3d115>
// @Description: DELETE burial data
router.delete("/burial/:id", (req, res) => {
    burialController.deleteBurialData(req, res);
});
module.exports = router;
