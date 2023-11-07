package views

import android.app.Dialog
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import com.google.gson.JsonParser
import com.hytan.agserviciosv1.R
import controllers.AddTypeController

class AgregarTipoDeMaquinariaActivity : AppCompatActivity() {
    private val addTypeController = AddTypeController()
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_agregar_tipo_de_maquinaria)

        //Volver
        val volver = findViewById<Button>(R.id.buttonVolverAgregarTDM)
        volver.setOnClickListener{
            val volver = Intent(this,MenuGestionSistemaActivity::class.java)
            startActivity(volver)
            finish()
        }

        //Agregar TDM
        val agregar = findViewById<Button>(R.id.buttonRegistrarTDM)
        val nameText = findViewById<EditText>(R.id.editNombreAgregarTDM)
        val descriptionText = findViewById<EditText>(R.id.editDescripcionAgregarTDM)

        agregar.setOnClickListener{
            val name = nameText.text.toString()
            val description =  descriptionText.text.toString()
            val agregar = addTypeController.addTypeAttempt(name,description,this) { response ->
                val jsonString = response.body?.string()
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