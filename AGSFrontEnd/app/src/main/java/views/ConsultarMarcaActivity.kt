package views

import android.app.Dialog
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import com.hytan.agserviciosv1.R

class ConsultarMarcaActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_consultar_marca)

        //Volver
        val volver = findViewById<Button>(R.id.buttonVolverCOnsultarMarca)
        volver.setOnClickListener{
            val volver = Intent(this,MenuGestionSistemaActivity::class.java)
            startActivity(volver)
            finish()
        }

        //Popup
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

    }
}
