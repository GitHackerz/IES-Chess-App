# Chess Timer App Documentation

## **1. Authentication Screens**

### **1.1 SignInScreen**

#### Purpose:
The `SignInScreen` is used for user authentication, allowing users to sign in using their credentials or social media accounts.

#### Components:
- **Logo**: Displays the app logo.
- **Sign-in Text**: Welcomes the user.
- **Social Media Buttons**: Allows sign-in with Google or Facebook using the `SocialButton` widget.
- **Email and Password Fields**: Input fields for credentials, including the custom `PasswordField`.
- **Forgot Password Link**: Navigates users to the `ForgotPasswordScreen`.
- **Sign In Button**: Authenticates the user and navigates to the `ChessMatchListScreen` upon success.
- **Sign Up Link**: Navigates to the `SignUpScreen`.

---

### **1.2 SignUpScreen**

#### Purpose:
The `SignUpScreen` allows users to create a new account.

#### Components:
- **Logo and Title**: Prompts users to create an account.
- **Text Fields**: Includes `CTextField` and `CPasswordField` for input.
- **Create Account Button**: Triggers sign-up logic and navigates to the `ChessMatchListScreen`.
- **Already Have an Account Link**: Navigates to the `SignInScreen`.

---

### **1.3 ForgotPasswordScreen**

#### Purpose:
The `ForgotPasswordScreen` allows users to recover their account via email.

#### Components:
- **Logo**: Indicates the reset process.
- **Email Input Field**: Accepts the user’s email.
- **Continue Button**: Sends the reset request to the backend.
- **Back to Sign In Button**: Navigates back to the `SignInScreen`.

---

### **1.4 Backend Integration for Authentication**

- **Sign Up**: The app sends user details (`name`, `email`, `password`) to the backend (`/user/sign-up`) to create a new account.
- **Sign In**: Credentials are sent to the backend (`/user/sign-in`) to authenticate the user.
- **Forgot Password**: Sends the email to the backend (`/user/forgot-password`) to trigger a reset link.

---

## **2. Chess Timer Functionality**

### **2.1 ChessTimerScreen**

#### Purpose:
Manages the chess timer for two players.

#### Dynamic Features:
- **Timers**: Tracks remaining time dynamically for both players.
- **Player Turns**: Switches between players and starts/stops the appropriate timer.
- **Dynamic Updates**: Timers decrement in real-time until paused or expired.

#### Backend Integration:
- Timer results (e.g., match duration) can be uploaded to the backend using a POST request to `/matches`.

---

### **2.2 Key Components:**

- **Player 1 Timer**: Counts down the time for Player 1.
- **Player 2 Timer**: Counts down the time for Player 2.
- **Switch Turns**: Switches control between players.
- **Dynamic Time Display**: Formats the time as `MM:SS`.

---

### **2.3 Dynamic Code Example**

```dart
ElevatedButton(
  onPressed: isPlayer1Turn ? null : switchToPlayer1,
  child: Text('Player 1 Timer'),
),
ElevatedButton(
  onPressed: !isPlayer1Turn ? null : switchToPlayer2,
  child: Text('Player 2 Timer'),
),
Text(
  'Player 1 Time: ${formatTime(player1Time)}',
  style: TextStyle(fontSize: 30),
),
Text(
  'Player 2 Time: ${formatTime(player2Time)}',
  style: TextStyle(fontSize: 30),
),
```

---

## **3. Match History**

### **3.1 ChessMatchListScreen**

#### Purpose:
Displays a list of previous chess matches.

#### Features:
- **Dynamic Match List**: Data fetched dynamically from the backend (`/matches`).
- **Drawer Menu**: Provides navigation to other screens (e.g., Home, Game Timer, AI Chatbot).
- **Match Details**: Includes player names, scores, date, and time for each match.

---

### **3.2 Backend Integration**

- **Fetch Matches**: Sends a GET request to `/matches` to retrieve a list of previous matches.
- **Dynamic Data Example**:
  ```dart
  Future<List<Match>> fetchMatches() async {
    final response = await http.get(Uri.parse('https://api.example.com/matches'));
    return parseMatches(response.body);
  }
  ```

---

### **3.3 Dynamic Code Example**

```dart
ListView.builder(
  itemCount: matches.length,
  itemBuilder: (context, index) {
    final match = matches[index];
    return ChessMatchTile(
      playerName: match.playerName,
      aiName: match.aiName,
      score: match.score,
      matchDate: match.date,
      matchTime: match.time,
    );
  },
),
```

---

## **4. Routing**

### **Navigation Between Screens:**
- `SignInScreen` → `ChessMatchListScreen`: Triggered after successful login.
- `ChessMatchListScreen` → `ChessTimerScreen`: Allows users to start a new game.
- Routes are defined dynamically for seamless navigation.

---

## **5. General App Architecture**

### **5.1 Widgets**
- Custom widgets (`SocialButton`, `CTextField`, `CPasswordField`, `ChessMatchTile`) ensure reusable and consistent UI.

### **5.2 State Management**
- View models manage screen states dynamically, with inputs validated in real-time.

### **5.3 Backend Integration**
- Authentication (`/user` endpoints) and match history (`/matches`) are handled with secure API calls.

---

## **Conclusion**

The Chess Timer application combines robust features, dynamic interfaces, and backend integration to deliver a seamless experience for chess enthusiasts. Its modular architecture ensures scalability and maintainability, with potential for future enhancements like AI integration or leaderboard functionality.
