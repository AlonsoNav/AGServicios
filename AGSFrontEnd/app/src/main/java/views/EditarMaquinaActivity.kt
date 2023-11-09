package views

import android.app.Dialog
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.ArrayAdapter
import android.widget.Button
import android.widget.EditText
import android.widget.Spinner
import android.widget.TextView
import com.google.gson.JsonParser
import com.hytan.agserviciosv1.R
import controllers.AddMachineController
import controllers.GetBrandController
import controllers.GetTypeController
import controllers.UpdateMachineController
import controllers.UpdateTypeController

class EditarMaquinaActivity : AppCompatActivity() {
    private val updateMachineController = UpdateMachineController()
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_editar_maquina)
        //Volver
        val volver = findViewById<Button>(R.id.buttonVolverEditarMaquina)
        volver.setOnClickListener{
            val volver = Intent(this,MenuGestionSistemaActivity::class.java)
            startActivity(volver)
            finish()
        }

        //Editar
        val editar = findViewById<Button>(R.id.buttonEditarMaquina)
        val serialText = findViewById<EditText>(R.id.editSerialEditarMaquina)
        val newSerialText = findViewById<EditText>(R.id.editNuevaSerialEditarMaquina)
        val modelText = findViewById<EditText>(R.id.editModeloEditarMaquina)

        editar.setOnClickListener{
            val serial = serialText.text.toString()
            val newSerial = newSerialText.text.toString()
            val model =  modelText.text.toString()
            val editar = updateMachineController.updateMachineAttempt(serial,newSerial,model,this) { response ->
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