package views

import android.app.Dialog
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
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
        val dialog = Dialog(this)
        dialog.getWindow()?.setBackgroundDrawableResource(android.R.color.transparent);
        dialog.getWindow()?.getAttributes()?.windowAnimations = R.style.CustomDialogAnimation
        dialog.setContentView(R.layout.popupinformativo)
        dialog.setCancelable(true)


        buttonLogin.setOnClickListener{
            val username = editTextUser.text.toString()
            val password =  editTextPassword.text.toString()
            val Intent = Intent(this,MainMenuActivity::class.java)
            val closeButton = dialog.findViewById<Button>(R.id.buttonListoPU)
            val textViewPopup = dialog.findViewById<TextView>(R.id.textViewPUP)
            val login = loginController.loginAttempt(username,password,this){

            }



        }
    }
}

