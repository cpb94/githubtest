$PBExportHeader$wtc_traspaso_almacen.srw
forward
global type wtc_traspaso_almacen from window
end type
type st_info from statictext within wtc_traspaso_almacen
end type
type pb_1 from picturebutton within wtc_traspaso_almacen
end type
type barra_1 from hprogressbar within wtc_traspaso_almacen
end type
type cb_1 from commandbutton within wtc_traspaso_almacen
end type
type p_logo from picture within wtc_traspaso_almacen
end type
type st_titulo from statictext within wtc_traspaso_almacen
end type
end forward

global type wtc_traspaso_almacen from window
integer width = 2619
integer height = 620
boolean titlebar = true
string title = "Traspaso de Almacen"
string menuname = "mi_menu_generico"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_info st_info
pb_1 pb_1
barra_1 barra_1
cb_1 cb_1
p_logo p_logo
st_titulo st_titulo
end type
global wtc_traspaso_almacen wtc_traspaso_almacen

type variables
Long id_ventana_activa
Boolean parar
end variables

on wtc_traspaso_almacen.create
if this.MenuName = "mi_menu_generico" then this.MenuID = create mi_menu_generico
this.st_info=create st_info
this.pb_1=create pb_1
this.barra_1=create barra_1
this.cb_1=create cb_1
this.p_logo=create p_logo
this.st_titulo=create st_titulo
this.Control[]={this.st_info,&
this.pb_1,&
this.barra_1,&
this.cb_1,&
this.p_logo,&
this.st_titulo}
end on

on wtc_traspaso_almacen.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_info)
destroy(this.pb_1)
destroy(this.barra_1)
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

barra_1.SetStep = 1
barra_1.Position = 0

end event

type st_info from statictext within wtc_traspaso_almacen
integer x = 1207
integer y = 176
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

type pb_1 from picturebutton within wtc_traspaso_almacen
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

type barra_1 from hprogressbar within wtc_traspaso_almacen
integer x = 37
integer y = 328
integer width = 2519
integer height = 68
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 10
end type

type cb_1 from commandbutton within wtc_traspaso_almacen
integer x = 37
integer y = 160
integer width = 1038
integer height = 104
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Iniciar Traspaso"
end type

event clicked;Datetime ahora
Date ahoradate
Long numero, i, rtn
String sel
String almacen, zona, articulo, familia, calidad, tono
Int fila, altura, calibre
String formato, tipo_pallet, caja, tipo_unidad
str_almacenmovimientos movimiento_nuevo
Datastore movimiento_antiguo

rtn = 1

if MessageBox("ATENCIÓN","Se regularizarán las direferencias entre el nuevo almacén y el existente. ¿Desea continuar?",Question!, Yesno!, 2) <> 1 then
	return
end if

ahoradate = Today()
ahora = Datetime(ahoradate, Now())

Parent.setredraw(true)

st_info.text = "Proceso Inciado."

sel =	"SELECT empresa, "+&
"almacen, "+&
"zona, "+&
"fila, "+&
"altura, "+&
"articulo, "+&
"familia, "+&
"calidad, "+&
"tono, "+&
"calibre, "+&
"SUM (cantidade - cantidads) AS existencias "+&
"FROM almacenmovimientos "+&
"WHERE NOT EXISTS (SELECT * FROM almlinubica "+&
"WHERE "+&
"almlinubica.almacen  = almacenmovimientos.almacen AND "+&
"almlinubica.zona = almacenmovimientos.zona AND "+&
"almlinubica.fila = almacenmovimientos.fila AND "+&
"almlinubica.altura = almacenmovimientos.altura AND "+&
"almlinubica.articulo = almacenmovimientos.articulo AND "+& 
"almlinubica.familia = almacenmovimientos.familia  AND "+&
"almlinubica.calidad = almacenmovimientos.calidad AND "+&
"almlinubica.tonochar = almacenmovimientos.tono AND "+&
"almlinubica.calibre = almacenmovimientos.calibre) "+&
"GROUP BY empresa, "+&
"almacen, "+&
"zona, "+&
"fila, "+&
"altura, "+&
"articulo, "+&
"familia, "+&
"calidad, "+&
"tono, "+&
"calibre "+&
"HAVING SUM (cantidade - cantidads) <> 0"
	
f_cargar_cursor_transaccion (SQLCA,  movimiento_antiguo,  sel)
numero = movimiento_antiguo.RowCount()
barra_1.setRange(1,numero)
i = 1
do while (i <= numero AND rtn = 1) 
	almacen = movimiento_antiguo.object.almacen[i]
	zona = movimiento_antiguo.object.zona[i]
	fila = movimiento_antiguo.object.fila[i]
	altura = movimiento_antiguo.object.altura[i]
	articulo = movimiento_antiguo.object.articulo[i]
	familia = movimiento_antiguo.object.familia[i]
	calidad = movimiento_antiguo.object.calidad[i]
	tono = movimiento_antiguo.object.tono[i]
	calibre = movimiento_antiguo.object.calibre[i]
	
	movimiento_nuevo.empresa = codigo_empresa
	movimiento_nuevo.fecha_mov = Datetime('31/12/2013')
	movimiento_nuevo.orden = 0
	movimiento_nuevo.fecha_intr = ahora
	movimiento_nuevo.origen = ''
//	movimiento_nuevo.nummov = ''
	movimiento_nuevo.almacen = almacen
	movimiento_nuevo.zona = zona
	movimiento_nuevo.fila = fila
	movimiento_nuevo.altura = altura
	movimiento_nuevo.articulo = articulo
	movimiento_nuevo.familia = familia
	movimiento_nuevo.calidad = calidad
	movimiento_nuevo.tono = tono
	movimiento_nuevo.calibre = calibre
	
	if movimiento_antiguo.object.existencias[i] > 0 then
		movimiento_nuevo.tipomov = '8' //REG (S)
		movimiento_nuevo.cantidade = 0
		movimiento_nuevo.cantidads = movimiento_antiguo.object.existencias[i]
	else
		movimiento_nuevo.tipomov = '7' //REG (E)
		movimiento_nuevo.cantidade = -1 * movimiento_antiguo.object.existencias[i]
		movimiento_nuevo.cantidads = 0
	end if
	
	SELECT TOP 1 formato, tipo_pallet, caja, tipo_unidad 
	INTO :formato, :tipo_pallet, :caja, :tipo_unidad
	FROM almacenmovimientos 
	WHERE empresa = :codigo_empresa
	AND almacen = :almacen
	AND zona = :zona
	AND fila = :fila
	AND altura = :altura
	AND articulo = :articulo
	AND familia = :familia
	AND calidad = :calidad
	AND tono = :tono
	AND calibre = :calibre;
		
	movimiento_nuevo.formato = formato
	movimiento_nuevo.tipo_pallet = tipo_pallet
	movimiento_nuevo.caja = caja
	movimiento_nuevo.tipo_unidad = tipo_unidad
	movimiento_nuevo.observaciones = "REGULARIZACIÓN almlinubica ALMACEN NUEVO 01/2014"
	movimiento_nuevo.trazabilidad = ""	
	movimiento_nuevo.usuario = "TENCER"
	
	
	if ftc_movimiento_almacen(movimiento_nuevo, trans_ts) <> 0 then
		rtn = 0
		ROLLBACK USING trans_ts;
	else
		rtn = 1
		COMMIT USING trans_ts;
	end if
	
	DISCONNECT USING trans_ts;
	
	st_info.text = "Movimiento "+String(i)+ " de "+String(numero)
	
	barra_1.StepIt()
	i++
loop

if rtn = 1 then
	st_info.text = "Traspaso completado. Movimientos: "+String(numero)
else
	st_info.text = "Error Traspaso. Movimiento: "+String(i - 1)
end if

Destroy movimiento_antiguo


end event

type p_logo from picture within wtc_traspaso_almacen
integer x = 2039
integer y = 20
integer width = 517
integer height = 96
string picturename = "C:\Tencer_PB12\tencer24.jpg"
boolean focusrectangle = false
end type

type st_titulo from statictext within wtc_traspaso_almacen
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

