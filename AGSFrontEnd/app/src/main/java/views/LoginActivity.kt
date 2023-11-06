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
import com.google.gson.JsonParser

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
            val login = loginController.loginAttempt(username,password,this) { response ->
                if (response.isSuccessful) {
                    val Intent = Intent(this,MainMenuActivity::class.java)
                    startActivity(Intent)
                    finish()
                } else {
                    runOnUiThread{
                        val dialog = Dialog(this)
                        dialog.getWindow()
                            ?.setBackgroundDrawableResource(android.R.color.transparent);
                        dialog.getWindow()?.getAttributes()?.windowAnimations =
                            R.style.CustomDialogAnimation
                        dialog.setContentView(R.layout.popupinformativo)
                        dialog.setCancelable(true)
                        val closeButton = dialog.findViewById<Button>(R.id.buttonListoPUP)
                        val textViewPopup = dialog.findViewById<TextView>(R.id.textViewPUP)
                        val jsonString = response.body?.string()
                        val jsonObject = JsonParser().parse(jsonString).asJsonObject
                        textViewPopup.text = jsonObject.get("message").asString
                        closeButton.setOnClickListener {
                            dialog.dismiss()
                        }
                        dialog.show()
                    }
                }
            }
            }



        }
    }
}

