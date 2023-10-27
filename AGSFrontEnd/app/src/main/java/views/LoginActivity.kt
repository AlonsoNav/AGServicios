package views

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import com.hytan.agserviciosv1.R
import controllers.LoginController

class LoginActivity : AppCompatActivity() {

    private val loginController = LoginController()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_login)

        val editTextUser = findViewById<EditText>(R.id.editTextUser)
        val editTextPassword= findViewById<EditText>(R.id.editTextPassword)
        val buttonLogin = findViewById<Button>(R.id.buttonLogin)

        buttonLogin.setOnClickListener{
            val username = editTextUser.text.toString()
            val password =  editTextPassword.text.toString()

            loginController.loginAttempt(username,password,this)
        }
    }

}