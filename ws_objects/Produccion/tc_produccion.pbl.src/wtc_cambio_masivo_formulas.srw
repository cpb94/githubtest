$PBExportHeader$wtc_cambio_masivo_formulas.srw
forward
global type wtc_cambio_masivo_formulas from window
end type
type formula_destino from singlelineedit within wtc_cambio_masivo_formulas
end type
type sle_destino from singlelineedit within wtc_cambio_masivo_formulas
end type
type sle_origen from singlelineedit within wtc_cambio_masivo_formulas
end type
type formula_origen from singlelineedit within wtc_cambio_masivo_formulas
end type
type st_2 from statictext within wtc_cambio_masivo_formulas
end type
type st_1 from statictext within wtc_cambio_masivo_formulas
end type
type st_info from statictext within wtc_cambio_masivo_formulas
end type
type pb_salir from picturebutton within wtc_cambio_masivo_formulas
end type
type cb_1 from commandbutton within wtc_cambio_masivo_formulas
end type
type p_logo from picture within wtc_cambio_masivo_formulas
end type
type st_titulo from statictext within wtc_cambio_masivo_formulas
end type
end forward

global type wtc_cambio_masivo_formulas from window
integer width = 2619
integer height = 784
boolean titlebar = true
string title = "Cambio masivo Formulas"
string menuname = "mi_menu_generico"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
formula_destino formula_destino
sle_destino sle_destino
sle_origen sle_origen
formula_origen formula_origen
st_2 st_2
st_1 st_1
st_info st_info
pb_salir pb_salir
cb_1 cb_1
p_logo p_logo
st_titulo st_titulo
end type
global wtc_cambio_masivo_formulas wtc_cambio_masivo_formulas

type variables
Long id_ventana_activa
Boolean parar
end variables

on wtc_cambio_masivo_formulas.create
if this.MenuName = "mi_menu_generico" then this.MenuID = create mi_menu_generico
this.formula_destino=create formula_destino
this.sle_destino=create sle_destino
this.sle_origen=create sle_origen
this.formula_origen=create formula_origen
this.st_2=create st_2
this.st_1=create st_1
this.st_info=create st_info
this.pb_salir=create pb_salir
this.cb_1=create cb_1
this.p_logo=create p_logo
this.st_titulo=create st_titulo
this.Control[]={this.formula_destino,&
this.sle_destino,&
this.sle_origen,&
this.formula_origen,&
this.st_2,&
this.st_1,&
this.st_info,&
this.pb_salir,&
this.cb_1,&
this.p_logo,&
this.st_titulo}
end on

on wtc_cambio_masivo_formulas.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.formula_destino)
destroy(this.sle_destino)
destroy(this.sle_origen)
destroy(this.formula_origen)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_info)
destroy(this.pb_salir)
destroy(this.cb_1)
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

end event

type formula_destino from singlelineedit within wtc_cambio_masivo_formulas
event key pbm_keydown
integer x = 745
integer y = 280
integer width = 320
integer height = 88
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event key;string campo, cliente
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

busqueda.filtro_es_codigo = false
if key =  keyEnter! then
	busqueda.titulo_ventana = "Búsqueda de Formulas"
	busqueda.consulta  = "SELECT formula, descripcion_produccion FROM prodformula WHERE EMPRESA = '"+codigo_empresa+"' ORDER BY descripcion_produccion"
	busqueda.titulos[1] = "Código"
	busqueda.titulos[2] = "Formula"
			
	OpenWithParm(wt_busquedas, busqueda)
	resultado = Message.PowerObjectParm
	if resultado.resultado > 0 then
		this.text		= resultado.valores[1]			
		sle_destino.text 	= resultado.valores[2]
		
	end if		
			
end if	
end event

event losefocus;string resultado

SELECT descripcion_produccion
INTO :resultado
FROM prodformula
WHERE empresa = :codigo_empresa
and formula = :this.text;

if SQLCA.sqlcode <> 100 then
	sle_destino.text	= resultado
else
	this.text = ''
	sle_destino.text	=  ''
	return 2			
end if
end event

type sle_destino from singlelineedit within wtc_cambio_masivo_formulas
integer x = 1097
integer y = 284
integer width = 1157
integer height = 88
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 30527953
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type sle_origen from singlelineedit within wtc_cambio_masivo_formulas
integer x = 1093
integer y = 172
integer width = 1157
integer height = 88
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 30527953
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type formula_origen from singlelineedit within wtc_cambio_masivo_formulas
event key pbm_keydown
integer x = 745
integer y = 172
integer width = 320
integer height = 88
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event key;string campo, cliente
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

busqueda.filtro_es_codigo = false
if key =  keyEnter! then
	busqueda.titulo_ventana = "Búsqueda de Formulas"
	busqueda.consulta  = "SELECT formula, descripcion_produccion FROM prodformula WHERE EMPRESA = '"+codigo_empresa+"' ORDER BY descripcion_produccion"
	busqueda.titulos[1] = "Código"
	busqueda.titulos[2] = "Formula"
			
	OpenWithParm(wt_busquedas, busqueda)
	resultado = Message.PowerObjectParm
	if resultado.resultado > 0 then
		this.text		= resultado.valores[1]			
		sle_origen.text 	= resultado.valores[2]
		
	end if		
			
end if	
end event

event losefocus;string resultado

SELECT descripcion_produccion
INTO :resultado
FROM prodformula
WHERE empresa = :codigo_empresa
and formula = :this.text;

if SQLCA.sqlcode <> 100 then
	sle_origen.text	= resultado
else
	this.text = ''
	sle_origen.text	=  ''
	return 2			
end if

end event

type st_2 from statictext within wtc_cambio_masivo_formulas
integer x = 206
integer y = 296
integer width = 448
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
string text = "Formula destino: "
boolean focusrectangle = false
end type

type st_1 from statictext within wtc_cambio_masivo_formulas
integer x = 206
integer y = 172
integer width = 421
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
string text = "Formula origen: "
boolean focusrectangle = false
end type

type st_info from statictext within wtc_cambio_masivo_formulas
integer x = 1321
integer y = 460
integer width = 1134
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type pb_salir from picturebutton within wtc_cambio_masivo_formulas
integer x = 2409
integer y = 164
integer width = 146
integer height = 128
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

type cb_1 from commandbutton within wtc_cambio_masivo_formulas
integer x = 142
integer y = 444
integer width = 1038
integer height = 104
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Iniciar Cambio Formulas"
end type

event clicked;String f_origen, f_destino
Transaction tr
Int borrar
str_ventana_alerta parametros

f_origen = formula_origen.text
f_destino = formula_destino.text

if isnull(f_origen) or f_origen = "" or  isnull(f_destino) or f_destino = "" then
	MessageBox("Error", "Debe indicar las formulas de origen y destino")
	return
end if

parametros.titulo = "ATENCIÓN. Cambio de formulas"
parametros.subtitulo = "Cambio NO REVERSIBLE"
parametros.mensaje = "Se sustituirán las formulas indicadas en el alta de producción, ¿Desea continuar?"
parametros.tipo = 1
//parametros.botones = botones
parametros.mostrar_imagen = true
openwithparm(wtc_ventana_alerta, parametros)
borrar = Int(Message.DoubleParm)

if borrar <> 1 then
	st_info.text = ""
	return
end if



st_info.text = "CAMBIANDO FORMULAS"

f_crear_transaccion(tr ,"" ,"" ,false, "TS","")	
CONNECT USING tr;

UPDATE art_ver_op_aplicaciones SET formula = :f_destino WHERE formula = :f_origen USING tr;

if tr.SqlCode = -1 then 
	ROLLBACK USING tr;
	st_info.text = "ERROR CAMBIO FORMULAS"
else
	COMMIT USING tr;
	st_info.text = "FORMULAS CAMBIADAS CON ÉXITO"
end if

DISCONNECT USING tr;


end event

type p_logo from picture within wtc_cambio_masivo_formulas
integer x = 2039
integer y = 20
integer width = 517
integer height = 96
string picturename = "C:\Tencer_PB12\tencer24.jpg"
boolean focusrectangle = false
end type

type st_titulo from statictext within wtc_cambio_masivo_formulas
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

