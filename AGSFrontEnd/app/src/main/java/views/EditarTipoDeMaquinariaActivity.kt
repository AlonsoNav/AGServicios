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
import controllers.UpdateTypeController

class EditarTipoDeMaquinariaActivity : AppCompatActivity() {
    private val updateTypeController = UpdateTypeController()
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_editar_tipo_de_maquinaria)

        //Pop up
        val dialog = Dialog(this)
        dialog.setContentView(R.layout.popupinformativo)
        dialog.setCancelable(true)
        dialog.getWindow()?.setBackgroundDrawableResource(android.R.color.transparent)
        dialog.getWindow()?.getAttributes()?.windowAnimations = R.style.CustomDialogAnimation

        //Volver
        val volver = findViewById<Button>(R.id.buttonVolverEditarTDM)
        volver.setOnClickListener{
            val volver = Intent(this,MenuGestionSistemaActivity::class.java)
            startActivity(volver)
            finish()
        }

        //Editar TDM
        val editar = findViewById<Button>(R.id.buttonEditarTDM)
        val nameText = findViewById<EditText>(R.id.editNombreEditarTDM)
        val newNameText = findViewById<EditText>(R.id.editNuevoNombreEditarTDM)
        val descriptionText = findViewById<EditText>(R.id.editDescripcionEditarTDM)

        editar.setOnClickListener{
            val name = nameText.text.toString()
            val newName = newNameText.text.toString()
            val description =  descriptionText.text.toString()
            val editar = updateTypeController.updateTypeAttempt(name,newName,description,this) { response ->
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