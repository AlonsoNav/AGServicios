package views

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.ImageButton
import com.hytan.agserviciosv1.R

class MenuGestionSistemaActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_menu_gestion_sistema)
        val volverGM = findViewById<Button>(R.id.buttonVolverGM)

        //Gestión de máquinas
        val eliminarGM = findViewById<ImageButton>(R.id.borrarMaquina)
        val registrarGM = findViewById<ImageButton>(R.id.agregarMaquina)
        val consultarGM = findViewById<ImageButton>(R.id.consultarMaquina)
        val editarGM = findViewById<ImageButton>(R.id.editarMaquina)

        // Gestión de maquinaria

        // Gestión de clientes

        val eliminarGC = findViewById<ImageButton>(R.id.borrarClientes)
        val registarGC = findViewById<ImageButton>(R.id.agregarClientes)
        val consultarGC = findViewById<ImageButton>(R.id.consultarClientes)
        val editarGC = findViewById<ImageButton>(R.id.editarClientes)

        volverGM.setOnClickListener{
            val volverMM = Intent(this,MainMenuActivity::class.java)
            startActivity(volverMM)
            finish()
        }

        //Gestión de máquinas
        eliminarGM.setOnClickListener{
            val eliminarGM = Intent(this, EliminarMaquinaActivity::class.java)
            startActivity(eliminarGM)
            finish()
        }

        registrarGM.setOnClickListener {
            val registrarGM = Intent(this, AgregarMaquinaActivity::class.java)
            startActivity(registrarGM)
            finish()
        }

        consultarGM.setOnClickListener {
            val consultarGM = Intent(this, ConsultarMaquinaActivity::class.java)
            startActivity(consultarGM)
            finish()
        }

        editarGM.setOnClickListener {

            val editarGM = Intent(this, EditarMaquinaActivity::class.java)
            startActivity(editarGM)
            finish()
        }

        //Gestión de clientes

        eliminarGC.setOnClickListener {

            val eliminarGC = Intent(this, EliminarClienteActivity::class.java)
            startActivity(eliminarGC)
            finish()

        }

        consultarGC.setOnClickListener{

            val consultarGC = Intent(this, ConsultarClienteActivity::class.java)
            startActivity(consultarGC)
            finish()
        }


    }

}