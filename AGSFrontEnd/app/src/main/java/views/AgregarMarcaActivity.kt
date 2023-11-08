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
import controllers.AddBrandController

class AgregarMarcaActivity : AppCompatActivity() {
    private val addBrandController = AddBrandController()
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_agregar_marca)

        //:D
        //Volver
        val volver = findViewById<Button>(R.id.buttonVolverAgregarMarca)
        volver.setOnClickListener{
            val volver = Intent(this, MenuGestionSistemaActivity::class.java)
            startActivity(volver)
            finish()
        }

        //Agregar Marca
        val agregar = findViewById<Button>(R.id.buttonRegistrarMarca)
        val nameText = findViewById<EditText>(R.id.editNombreAgregarMarca)
        val descriptionText = findViewById<EditText>(R.id.editDescripcionAgregarMarca)

        agregar.setOnClickListener{
            val name = nameText.text.toString()
            val description =  descriptionText.text.toString()
            val agregar = addBrandController.addBrandAttempt(name,description,this) { response ->
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