$PBExportHeader$wtc_traspaso_modelo_origen.srw
forward
global type wtc_traspaso_modelo_origen from window
end type
type st_info from statictext within wtc_traspaso_modelo_origen
end type
type cb_3 from commandbutton within wtc_traspaso_modelo_origen
end type
type pb_1 from picturebutton within wtc_traspaso_modelo_origen
end type
type barra_1 from hprogressbar within wtc_traspaso_modelo_origen
end type
type p_logo from picture within wtc_traspaso_modelo_origen
end type
type st_titulo from statictext within wtc_traspaso_modelo_origen
end type
end forward

global type wtc_traspaso_modelo_origen from window
integer width = 2619
integer height = 860
boolean titlebar = true
string title = "Traspaso a multicodigo"
string menuname = "mi_menu_generico"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_info st_info
cb_3 cb_3
pb_1 pb_1
barra_1 barra_1
p_logo p_logo
st_titulo st_titulo
end type
global wtc_traspaso_modelo_origen wtc_traspaso_modelo_origen

type variables
Long id_ventana_activa
Boolean parar
end variables

forward prototypes
public function integer fr_traspaso (string empresa, string codigo, string version_art, transaction trm, ref string modelo_origen, ref string pieza_origen, ref string prueba_origen)
end prototypes

public function integer fr_traspaso (string empresa, string codigo, string version_art, transaction trm, ref string modelo_origen, ref string pieza_origen, ref string prueba_origen);Int esta= 0, resultado = 1
String sel, articulo_anterior, uso
Long numero_articulos, i
Datastore versiones

sel = "SELECT art_escandallo.articulo, articulos.uso "+&
		"FROM art_escandallo "+&
		"INNER JOIN articulos ON art_escandallo.empresa = articulos.empresa AND art_escandallo.articulo = articulos.codigo "+&
		"WHERE art_escandallo.empresa = '"+empresa+"' AND art_escandallo.articulo_ant = '"+codigo+"' AND art_escandallo.version = '"+version_art+"' "
f_cargar_cursor_trans (trm,  sel, versiones)
numero_articulos = versiones.RowCount()
if numero_articulos > 1 then
	modelo_origen = ""
	pieza_origen = ""
	prueba_origen = ""
	return 1
	destroy versiones
end if
i = 1
do while (i <= numero_articulos AND resultado = 1) 
	traspaso_numero_nodos++
	
	if traspaso_numero_nodos > 300 then
		MessageBox("Error", "Demasiados nodos en el artículo. Posible error de estructura")
		return -1
	end if
	
	articulo_anterior = versiones.object.art_escandallo_articulo[i]
	uso = versiones.object.articulos_uso[i]
	
	modelo_origen = ""
	pieza_origen = ""
	prueba_origen = ""
	SELECT modelo_origen, pieza_origen, prueba_origen 
	INTO :modelo_origen, :pieza_origen, :prueba_origen 
	FROM articulos 
	WHERE empresa = :empresa AND codigo = :articulo_anterior;
	
	if isnull(modelo_origen) OR modelo_origen = "" then
		//Pasar al siguiente artículo de la esctructura
		resultado = fr_traspaso(empresa, articulo_anterior, version_art, trm, modelo_origen, pieza_origen, prueba_origen)
		
		if resultado <> 1 then
			return -1
		end if
	end if
	i++
loop
	
destroy versiones
return resultado
end function

on wtc_traspaso_modelo_origen.create
if this.MenuName = "mi_menu_generico" then this.MenuID = create mi_menu_generico
this.st_info=create st_info
this.cb_3=create cb_3
this.pb_1=create pb_1
this.barra_1=create barra_1
this.p_logo=create p_logo
this.st_titulo=create st_titulo
this.Control[]={this.st_info,&
this.cb_3,&
this.pb_1,&
this.barra_1,&
this.p_logo,&
this.st_titulo}
end on

on wtc_traspaso_modelo_origen.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_info)
destroy(this.cb_3)
destroy(this.pb_1)
destroy(this.barra_1)
destroy(this.p_logo)
destroy(this.st_titulo)
end on

event open;select nombre
into :st_titulo.text
from empresas
where empresa = :codigo_empresa;


parar = false
end event

event close;f_menu_cerrar_ventana(this,id_ventana_activa)
end event

event activate;id_ventana_activa = f_menu_insertar_ventana(this)

barra_1.SetStep = 1
barra_1.Position = 0

end event

type st_info from statictext within wtc_traspaso_modelo_origen
integer x = 59
integer y = 164
integer width = 1888
integer height = 148
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_3 from commandbutton within wtc_traspaso_modelo_origen
integer x = 123
integer y = 356
integer width = 1038
integer height = 104
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Traspaso"
end type

event clicked;String sel, mensaje
Int numero, i, rtn, nivel, nivel_antiguo, operaciones, numero_articulos, pedido, linped, maximo_nivel
Dec ot
String codigo, articulo_actual, articulo_anterior, version_plani, base, articulo_nuevo
String modelo_origen, pieza_origen, prueba_origen, version_art
transaction trm

rtn = 1

//Buscamos artículos no traspasados bloqueando solo el artículo afectado
SELECT COUNT(*) INTO :numero FROM articulos WHERE uso = '2'  AND modelo_origen IS NULL AND referencia_laboratorio IS NULL AND codigo NOT IN(SELECT codigo FROM articulos_traspasados);

barra_1.setRange(0,numero)
barra_1.Position = 0
barra_1.setredraw(true)
i=1
st_info.text = "Inicio traspaso. Total a traspasar: "+String(numero)+" artículos"

//TRASPASO DE ARTICULOS
do while (rtn = 1 AND parar = false) 
	f_crear_transaccion(trm,"","",false,"TS","")
	//f_crear_transaccion(trm,"","",true,"RC","")
	CONNECT USING trm;
	
	codigo = ""
	SELECT codigo INTO :codigo 
	FROM articulos 
	WHERE uso = '2'  
	AND (modelo_origen IS NULL OR modelo_origen = '') 
	AND (referencia_laboratorio IS NULL OR referencia_laboratorio = '') 
	AND codigo NOT IN(SELECT codigo FROM articulos_traspasados) 
	USING trm;
	
	//	ORDER BY CONVERT(integer,codigo) ASC 
	//	AND codigo IN ('47012')  
	//AND codigo IN ('50468')  
	//AND codigo IN ('2', '33021', '5646', '33830', '33733', '15470')  
	//AND codigo IN (SELECT TOP 50 codigo FROM articulos WHERE uso = '3' ORDER BY CONVERT(dec,codigo) DESC)
	
	if not isnull(codigo) and codigo <> "" then
		
		traspaso_numero_nodos = 0
		modelo_origen = ""
		pieza_origen = ""
		prueba_origen = ""
		version_art = ""
		
		SELECT TOP 1 version INTO :version_art 
		FROM art_escandallo WHERE empresa = :codigo_empresa AND articulo = :codigo
		USING trm;
		
		rtn = fr_traspaso(codigo_empresa, codigo, version_art, trm, modelo_origen, pieza_origen, prueba_origen)
		
		//RESULTADO
		IF rtn = 1 then
			if modelo_origen <> "" then
				UPDATE articulos SET 
				modelo_origen = :modelo_origen, 
				pieza_origen = :pieza_origen, 
				prueba_origen = :prueba_origen
				WHERE empresa = :codigo_empresa AND codigo = :codigo
				USING trm;
				if trm.SQLCode <> 0 THEN  
					MessageBox("SQL error", trm.SQLErrText +" UPDATE articulos "+String(trm.SQLDBCode))
					return -1
				end if
				
				st_info.text = "Artículo "+String(i)+" de "+String(numero)+" traspasado"
				barra_1.StepIt()
				i++	
				
			end if
			
			INSERT INTO articulos_traspasados (empresa, codigo) VALUES (:codigo_empresa, :codigo)
			USING trm;
			if trm.SQLCode <> 0 THEN  
				MessageBox("SQL error", trm.SQLErrText +" INSERT articulos_traspasados "+String(trm.SQLDBCode))
				return -1
			end if
			
			COMMIT USING trm;
		else
			ROLLBACK USING trm;
			mensaje = "Error en el traspaso. Artículo: "+ codigo
			MessageBox("Resultado de la operación",mensaje)			
			parar = true
		end if
	else
		parar = true
	end if
	
	DISCONNECT USING trm;
loop	

Destroy trm
parar = false

end event

type pb_1 from picturebutton within wtc_traspaso_modelo_origen
integer x = 2409
integer y = 156
integer width = 146
integer height = 128
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\Tencer_PB12\Log Out_24x24Gris.png"
alignment htextalign = left!
end type

event clicked;Close(Parent)
end event

type barra_1 from hprogressbar within wtc_traspaso_modelo_origen
integer x = 55
integer y = 528
integer width = 2505
integer height = 68
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 10
end type

type p_logo from picture within wtc_traspaso_modelo_origen
integer x = 2039
integer y = 20
integer width = 517
integer height = 96
string picturename = "C:\Tencer_PB12\tencer24.jpg"
boolean focusrectangle = false
end type

type st_titulo from statictext within wtc_traspaso_modelo_origen
integer x = 37
integer y = 32
integer width = 1710
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 23016974
long backcolor = 553648127
string text = "Nombre Empresa"
boolean focusrectangle = false
end type

