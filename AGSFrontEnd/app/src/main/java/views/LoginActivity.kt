package views

import android.app.Dialog
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import com.hytan.agserviciosv1.R
import controllers.LoginController
import kotlin.math.log

class LoginActivity : AppCompatActivity() {

    private val loginController = LoginController()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_login)

        val editTextUser = findViewById<EditText>(R.id.editTextUser)
        val editTextPassword= findViewById<EditText>(R.id.editTextPassword)
        val buttonLogin = findViewById<Button>(R.id.buttonLogin)
        val dialog = Dialog(this)
        dialog.setContentView(R.layout.popuplogin)
        dialog.setCancelable(true)


        buttonLogin.setOnClickListener{
            val username = editTextUser.text.toString()
            val password =  editTextPassword.text.toString()
            val Intent = Intent(this,MainMenuActivity::class.java)
            val login = loginController.loginAttempt(username,password,this)
            val closeButton = dialog.findViewById<Button>(R.id.buttonListoPU)
            val textViewPopup = dialog.findViewById<TextView>(R.id.textViewlogPU)

            //Para probar sin api, cambiar a -1
            if(login.first == -1) {
                startActivity(Intent)
                finish()
            } else if (login.first == -1){
                textViewPopup.text = "El API no se encuentra en línea"
                closeButton.setOnClickListener {
                    dialog.dismiss()
                }
                dialog.show()
            }else{
                textViewPopup.text = login.second
                closeButton.setOnClickListener {
                    dialog.dismiss()
                }
                dialog.show()
            }
        }
    }

}