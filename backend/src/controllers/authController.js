const User = require('../models/User');
const jwt = require('jsonwebtoken');

// Generate JWT
const generateToken = (id) => {
    return jwt.sign({ id }, process.env.JWT_SECRET || 'secret', {
        expiresIn: '30d',
    });
};

// @desc    Register new user
// @route   POST /api/auth/signup
// @access  Public
const registerUser = async (req, res) => {
    const { name, email, mobileNumber, password } = req.body;

    try {
        if (!email && !mobileNumber) {
            return res.status(400).json({ message: 'Please provide email or mobile number' });
        }

        // Check if user exists
        const query = [];
        if (email) query.push({ email });
        if (mobileNumber) query.push({ mobileNumber });

        const userExists = await User.findOne({ $or: query });

        if (userExists) {
            return res.status(400).json({ message: 'User already exists' });
        }

        const user = await User.create({
            name,
            email,
            mobileNumber,
            password,
        });

        if (user) {
            res.status(201).json({
                _id: user._id,
                name: user.name,
                email: user.email,
                mobileNumber: user.mobileNumber,
                token: generateToken(user._id),
            });
        } else {
            res.status(400).json({ message: 'Invalid user data' });
        }
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

// @desc    Authenticate a user
// @route   POST /api/auth/login
// @access  Public
const loginUser = async (req, res) => {
    const { email, mobileNumber, identifier, password } = req.body;

    try {
        let query = {};
        if (email) {
            query = { email };
        } else if (mobileNumber) {
            query = { mobileNumber };
        } else if (identifier) {
            query = { $or: [{ email: identifier }, { mobileNumber: identifier }] };
        } else {
            return res.status(400).json({ message: 'Please provide email, mobile number or identifier' });
        }

        const user = await User.findOne(query);

        if (user && (await user.matchPassword(password))) {
            res.json({
                _id: user._id,
                name: user.name,
                email: user.email,
                mobileNumber: user.mobileNumber,
                token: generateToken(user._id),
            });
        } else {
            res.status(401).json({ message: 'Invalid credentials' });
        }
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

module.exports = {
    registerUser,
    loginUser,
};
