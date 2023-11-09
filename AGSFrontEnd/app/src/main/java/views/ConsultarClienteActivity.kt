package views

import android.app.Dialog
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.ArrayAdapter
import android.widget.Button
import android.widget.EditText
import android.widget.ListView
import android.widget.TextView
import com.google.gson.JsonParser
import com.hytan.agserviciosv1.R
import controllers.GetClientController
import controllers.GetMachineController

class ConsultarClienteActivity : AppCompatActivity() {
    private val getClientController = GetClientController()
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_consultar_cliente)

        //Volver
        val volverCC = findViewById<Button>(R.id.buttonVolverConsultaCliente)
        volverCC.setOnClickListener{
            val volverCC = Intent(this, MenuGestionSistemaActivity::class.java)
            startActivity(volverCC)
            finish()
        }

        //Pop ups
        val dialogD = Dialog(this)
        dialogD.setContentView(R.layout.popup_display)
        dialogD.setCancelable(true)
        dialogD.getWindow()
            ?.setBackgroundDrawableResource(android.R.color.transparent);
        dialogD.getWindow()?.getAttributes()?.windowAnimations =
            R.style.CustomDialogAnimation

        val dialog = Dialog(this)
        dialog.getWindow()
            ?.setBackgroundDrawableResource(android.R.color.transparent);
        dialog.getWindow()?.getAttributes()?.windowAnimations =
            R.style.CustomDialogAnimation
        dialog.setContentView(R.layout.popupinformativo)
        dialog.setCancelable(true)

        //Consultar
        val consultar = findViewById<Button>(R.id.buttonConsultarCliente)
        val nameText = findViewById<EditText>(R.id.editNombreEmpresaCC)

        consultar.setOnClickListener {
            val name = nameText.text.toString()
            val consultar = getClientController.getClientAttempt(name,this) { response ->
                val jsonString = response.body?.string()
                val jsonObject = JsonParser().parse(jsonString).asJsonObject
                if(response.isSuccessful){
                    val listo = dialogD.findViewById<Button>(R.id.buttonListoPUPDisplay)
                    val textDisplay = dialogD.findViewById<TextView>(R.id.textViewPUPDisplay)
                    val lista = dialogD.findViewById<ListView>(R.id.listViewDisplay)
                    val items = ArrayList<String>()
                    textDisplay.text="Lista de clientes"
                    listo.setOnClickListener {
                        dialogD.dismiss()
                    }
                    val machinesArray = jsonObject.getAsJsonArray("clients")
                    for (i in 0 until machinesArray.size()) {
                        val typeObject = machinesArray.get(i)
                        val name = typeObject.asJsonObject.get("name").asString
                        val number = typeObject.asJsonObject.get("number").asString
                        val address = typeObject.asJsonObject.get("address").asString
                        val email = typeObject.asJsonObject.get("email").asString
                        val item = "Nombre: $name\nNúmero: $number\nDirección: $address\nCorreo: $email"
                        items.add(item)
                    }
                    runOnUiThread{
                        val adapter = ArrayAdapter(this, R.layout.list_text_color, items)
                        lista.adapter = adapter
                        dialogD.show()
                    }
                }else{
                    val closeButton = dialog.findViewById<Button>(R.id.buttonListoPUP)
                    val textViewPopup = dialog.findViewById<TextView>(R.id.textViewPUP)
                    closeButton.setOnClickListener {
                        dialog.dismiss()
                    }
                    runOnUiThread{
                        textViewPopup.text = jsonObject.get("message").asString
                        dialog.show()
                    }
                }
            }
        }
    }
}