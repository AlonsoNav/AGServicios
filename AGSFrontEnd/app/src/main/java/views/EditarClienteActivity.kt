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
import controllers.UpdateClientController

class EditarClienteActivity : AppCompatActivity() {
    private val updateClientController = UpdateClientController()
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_editar_cliente)

        //Volver
        val volver = findViewById<Button>(R.id.buttonVolverEditarCliente)
        volver.setOnClickListener {
            val volver = Intent(this, MenuGestionSistemaActivity::class.java)
            startActivity(volver)
            finish()
        }

        //Pop up
        val dialog = Dialog(this)
        dialog.setContentView(R.layout.popupinformativo)
        dialog.setCancelable(true)
        dialog.getWindow()?.setBackgroundDrawableResource(android.R.color.transparent)
        dialog.getWindow()?.getAttributes()?.windowAnimations = R.style.CustomDialogAnimation

        //Editar cliente
        val editar = findViewById<Button>(R.id.buttonEditarCliente)
        val oldNameText = findViewById<EditText>(R.id.editNombreEditarCliente)
        val nameText = findViewById<EditText>(R.id.editNuevoNombreEditarCliente)
        val numberText = findViewById<EditText>(R.id.editNuevoNumeroEditarCliente)
        val addressText = findViewById<EditText>(R.id.editNuevaDireccionEditarCliente)
        val emailText = findViewById<EditText>(R.id.editNuevoCorreoEditarCliente)

        editar.setOnClickListener {
            val name = oldNameText.text.toString()
            val newName = nameText.text.toString()
            var numberS = numberText.text.toString()
            val address = addressText.text.toString()
            val email = emailText.text.toString()
            val closeButton = dialog.findViewById<Button>(R.id.buttonListoPUP)
            val textViewPopup = dialog.findViewById<TextView>(R.id.textViewPUP)
            closeButton.setOnClickListener {
                dialog.dismiss()
            }
            if(numberS.isEmpty()){
                numberS="0"
            }
            val number = numberS.toInt()
            val editar = updateClientController.updateBrandAttempt(name, newName ,number,address,email, this) { response ->
                val jsonString = response.body?.string()
                runOnUiThread {
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