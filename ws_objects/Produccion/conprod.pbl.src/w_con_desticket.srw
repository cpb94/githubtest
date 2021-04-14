$PBExportHeader$w_con_desticket.srw
forward
global type w_con_desticket from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_desticket
end type
type pb_2 from upb_imprimir within w_con_desticket
end type
type cb_1 from commandbutton within w_con_desticket
end type
type em_fdesde from u_em_campo within w_con_desticket
end type
type em_fhasta from u_em_campo within w_con_desticket
end type
type cbx_pruebas_finalizadas from checkbox within w_con_desticket
end type
type uo_tecnico from u_em_campo_2 within w_con_desticket
end type
type p_imagen from picture within w_con_desticket
end type
type sle_modelo from singlelineedit within w_con_desticket
end type
type cb_2 from commandbutton within w_con_desticket
end type
type gb_7 from groupbox within w_con_desticket
end type
type gb_2 from groupbox within w_con_desticket
end type
type sle_pdesde from singlelineedit within w_con_desticket
end type
type sle_phasta from singlelineedit within w_con_desticket
end type
type st_1 from statictext within w_con_desticket
end type
type em_fdesde_fin from u_em_campo within w_con_desticket
end type
type em_fhasta_fin from u_em_campo within w_con_desticket
end type
type gb_3 from groupbox within w_con_desticket
end type
type gb_4 from groupbox within w_con_desticket
end type
type gb_5 from groupbox within w_con_desticket
end type
type uo_maquina from u_em_campo_2 within w_con_desticket
end type
type gb_1 from groupbox within w_con_desticket
end type
type gb_8 from groupbox within w_con_desticket
end type
type gb_9 from groupbox within w_con_desticket
end type
type gb_10 from groupbox within w_con_desticket
end type
type gb_11 from groupbox within w_con_desticket
end type
type dw_informe from datawindow within w_con_desticket
end type
type dw_stock_bases from datawindow within w_con_desticket
end type
end forward

global type w_con_desticket from w_int_con_empresa
integer x = 5
integer y = 32
integer width = 5198
integer height = 3848
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
em_fdesde em_fdesde
em_fhasta em_fhasta
cbx_pruebas_finalizadas cbx_pruebas_finalizadas
uo_tecnico uo_tecnico
p_imagen p_imagen
sle_modelo sle_modelo
cb_2 cb_2
gb_7 gb_7
gb_2 gb_2
sle_pdesde sle_pdesde
sle_phasta sle_phasta
st_1 st_1
em_fdesde_fin em_fdesde_fin
em_fhasta_fin em_fhasta_fin
gb_3 gb_3
gb_4 gb_4
gb_5 gb_5
uo_maquina uo_maquina
gb_1 gb_1
gb_8 gb_8
gb_9 gb_9
gb_10 gb_10
gb_11 gb_11
dw_informe dw_informe
dw_stock_bases dw_stock_bases
end type
global w_con_desticket w_con_desticket

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
public subroutine f_control2 (datawindow data)
end prototypes

public subroutine f_control (datawindow data);string filtro
Datetime fecha1_fin, fecha2_fin

data.SetTransObject(SQLCA)
data.retrieve(codigo_empresa, datetime(date(em_fdesde.text)), datetime(date(em_fhasta.text)),String(uo_maquina.em_codigo.text))

if isnull (sle_pdesde.text) or sle_pdesde.text = ''  then
	filtro =  ' 1 = 1 '
else
	if not isnull (sle_pdesde.text) and sle_pdesde.text <> '' and (isnull (sle_phasta.text) or sle_phasta.text = '') then
		filtro = " codigo_int  >= "+String(sle_pdesde.text)
	else
		if sle_pdesde.text <> '' and  sle_phasta.text <> ''  then
			filtro = ' codigo_int >= '+String(sle_pdesde.text)+' and codigo_int  <= '+String(sle_phasta.text)
		end if
	end if
end if

if cbx_pruebas_finalizadas.checked = false then
	filtro = filtro + " and   isnull (desticket_fecha_fin)  "
end if


if uo_tecnico.em_codigo.text <> '' and not isnull(uo_tecnico.em_codigo.text) then
	filtro = filtro + " and desticket_tecnico = '"+uo_tecnico.em_codigo.text+"' "
end if


if uo_tecnico.em_codigo.text <> '' and not isnull(uo_tecnico.em_codigo.text) then
	filtro = filtro + " and desticket_tecnico = '"+uo_tecnico.em_codigo.text+"' "
end if

if sle_modelo.text <> '' and not isnull(sle_modelo.text) then
	filtro = filtro + " and desticket_modelo = '"+sle_modelo.text+"' "
end if

if em_fdesde_fin.enabled then
	if not isnull(em_fdesde_fin.text) and em_fdesde_fin.text <> "" and em_fdesde_fin.text <> "00-00-00" &
		and not isnull(em_fhasta_fin.text) and em_fhasta_fin.text <> "" and em_fhasta_fin.text <> "00-00-00" then
		fecha1_fin = Datetime(em_fdesde_fin.text)
		fecha2_fin = Datetime(em_fhasta_fin.text)
		filtro = filtro + " and desticket_fecha_fin >= "+string(fecha1_fin,"yyyy-mm-dd 00:00:00")+" and desticket_fecha_fin <= "+string(fecha2_fin,"yyyy-mm-dd 00:00:00")+" "   
	end if
end if


dw_informe.SetFilter(filtro)

dw_informe.Filter( )


data.sort()
data.groupcalc()
data.setredraw(true)

p_imagen.PictureName = ""



data.TriggerEvent(rowfocuschanged!)


end subroutine

public subroutine f_control2 (datawindow data);string filtro, filtro2, codigo, descripcion, almacen, zona, sel, sel2, codigo_ante, cliente, razon
long i, j, fila, altura, nuevo_reg, estado, total_stock
dec existencias, cantidad
datastore ubicaciones, bases
Datetime fecha1_fin, fecha2_fin

dw_stock_bases.reset()

if sle_pdesde.text = ''  then
	filtro =  ' 1= 1 '
	filtro2 =  ' 1= 1 '
else
	if sle_pdesde.text <> ''   and  sle_phasta.text = ''  then
		filtro = " convert (integer, desticket.codigo) >= "+sle_pdesde.text
		filtro2 = " convert (integer, B.desticket.codigo) >= "+sle_pdesde.text
	else
		if sle_pdesde.text <> '' and  sle_phasta.text <> ''  then
			filtro = ' convert (integer, desticket.codigo) >= '+sle_pdesde.text+' and convert (integer, desticket.codigo)  <= '+sle_phasta.text
			filtro2 = ' convert (integer, B.codigo) >= '+sle_pdesde.text+' and convert (integer, B.codigo)  <= '+sle_phasta.text
		end if
	end if
end if

if not cbx_pruebas_finalizadas.checked then
	filtro = filtro + " and desticket.fecha_fin IS NULL "
	filtro2 = filtro2 + " and B.fecha_fin IS NULL  "
else
	if em_fdesde_fin.enabled then
		if not isnull(em_fdesde_fin.text) and em_fdesde_fin.text <> "" and em_fdesde_fin.text <> "00-00-00" &
			and not isnull(em_fhasta_fin.text) and em_fhasta_fin.text <> "" and em_fhasta_fin.text <> "00-00-00" then
			fecha1_fin = Datetime(em_fdesde_fin.text)
			fecha2_fin = Datetime(em_fhasta_fin.text)
			filtro = filtro + " and desticket.fecha_fin >= '"+em_fdesde_fin.text+"' and desticket.fecha_fin <= '"+em_fhasta_fin.text+"' "   
			filtro2 = filtro2 + " and B.fecha_fin >= '"+em_fdesde_fin.text+"' and B.fecha_fin <= '"+em_fhasta_fin.text+"' "   
		end if
	end if
end if

if uo_tecnico.em_codigo.text <> '' and not isnull(uo_tecnico.em_codigo.text) then
	filtro = filtro + " and desticket.tecnico = '"+uo_tecnico.em_codigo.text+"' "
end if

if sle_modelo.text <> '' and not isnull(sle_modelo.text) then
	filtro = filtro + " and desticket.modelo = '"+sle_modelo.text+"' "
end if

if uo_tecnico.em_codigo.text <> '' and not isnull(uo_tecnico.em_codigo.text) then
	filtro2 = filtro2 + " and B.tecnico = '"+uo_tecnico.em_codigo.text+"' "
end if


if sle_modelo.text <> '' and not isnull(sle_modelo.text) then
	filtro2 = filtro2 + " and B.modelo = '"+sle_modelo.text+"' "
end if


sel2 = " select distinct desticket.base , articulos.descripcion, articulos.cliente, "+&
									" ( select sum (cantidad) "+&
									" from desticket B " +&
									" where B.empresa = '"+codigo_empresa+"' "+&
									" and B.base = desticket.base "+&
									" and B.tipo_maquina = desticket.tipo_maquina "+&
									" and "+filtro2+" ) as cantidad "+&
		" from desticket, articulos "+&
		" where desticket.empresa = '"+codigo_empresa+"' "+&
		" and articulos.empresa = '"+codigo_empresa+"' "+&
		" and tipo_maquina = '"+String(uo_maquina.em_codigo.text)+"' "+&
		" and desticket.base = articulos.codigo "+&
		" and "+filtro+&
		" order by articulos.descripcion "

f_cargar_cursor_nuevo (sel2, bases)




for i = 1 to bases.rowcount()
	codigo = bases.object.desticket_base[i]
	descripcion = bases.object.articulos_descripcion[i]
	cantidad = bases.object.cantidad[i]
	cliente = bases.object.articulos_cliente[i]
	razon = ""
	estado = 2 // estado ok
	total_stock = 0 
	
	SELECT razon INTO :razon FROM genter WHERE empresa = :codigo_empresa AND codigo = :cliente;

	sel = " select almacen, zona, fila, altura, existencias "+&
			" from almlinubica "+&
			" where empresa = '"+codigo_empresa+"' "+&
			" and articulo = '"+codigo+"' "+&
			" and almacen = '4'"
	
	f_cargar_cursor_nuevo (sel, ubicaciones)

	if ubicaciones.rowcount() >= 1 then
		for j = 1 to ubicaciones.rowcount()
			almacen = ubicaciones.object.almacen[j]
			zona = ubicaciones.object.zona[j]
			fila = ubicaciones.object.fila[j]
			altura = ubicaciones.object.altura[j]
			existencias = ubicaciones.object.existencias[j]
			total_stock = total_stock + existencias
	
		
			nuevo_reg = dw_stock_bases.insertrow(0)
			dw_stock_bases.object.codigo[nuevo_reg] = codigo
			dw_stock_bases.object.descripcion [nuevo_reg] = descripcion
			dw_stock_bases.object.almacen [nuevo_reg] = almacen
			dw_stock_bases.object.zona[nuevo_reg] = zona
			dw_stock_bases.object.fila [nuevo_reg] = fila
			dw_stock_bases.object.altura [nuevo_reg] = altura
			dw_stock_bases.object.stock [nuevo_reg] = existencias
			dw_stock_bases.object.cantidad[nuevo_reg] = cantidad
			dw_stock_bases.object.cliente[nuevo_reg] = razon
			dw_stock_bases.object.estado[nuevo_reg] = 2
		next
	else
		//Mostramos también bases sin stock
		nuevo_reg = dw_stock_bases.insertrow(0)
		dw_stock_bases.object.codigo[nuevo_reg] = codigo
		dw_stock_bases.object.descripcion [nuevo_reg] = descripcion
		dw_stock_bases.object.almacen [nuevo_reg] = "-"
		dw_stock_bases.object.zona[nuevo_reg] = "-"
		dw_stock_bases.object.fila [nuevo_reg] = 0
		dw_stock_bases.object.altura [nuevo_reg] = 0
		dw_stock_bases.object.stock [nuevo_reg] = 0
		dw_stock_bases.object.cantidad[nuevo_reg] = cantidad
		dw_stock_bases.object.cliente[nuevo_reg] = razon
		dw_stock_bases.object.estado[nuevo_reg] = 0
		total_stock = 0 
	end if
	
	if total_stock <> 0 and total_stock < cantidad then
		dw_stock_bases.setfilter("codigo = '"+codigo+"'")
		dw_stock_bases.filter()
		for j = 1 to dw_stock_bases.rowcount()
			dw_stock_bases.object.estado[j] = 1
		next
		dw_stock_bases.setfilter("1 = 1")
		dw_stock_bases.filter()
	end if
	
	destroy ubicaciones
next

destroy bases








end subroutine

event close;call super::close;dw_informe.reset()

end event

event open;call super::open;string mes

istr_parametros.s_titulo_ventana="Consulta Pruebas Inkcid"
This.title=istr_parametros.s_titulo_ventana

em_fdesde.text = "01-04-11"
em_fhasta.text = string(today(),"dd-mm-yy")


end event

on w_con_desticket.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.cbx_pruebas_finalizadas=create cbx_pruebas_finalizadas
this.uo_tecnico=create uo_tecnico
this.p_imagen=create p_imagen
this.sle_modelo=create sle_modelo
this.cb_2=create cb_2
this.gb_7=create gb_7
this.gb_2=create gb_2
this.sle_pdesde=create sle_pdesde
this.sle_phasta=create sle_phasta
this.st_1=create st_1
this.em_fdesde_fin=create em_fdesde_fin
this.em_fhasta_fin=create em_fhasta_fin
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_5=create gb_5
this.uo_maquina=create uo_maquina
this.gb_1=create gb_1
this.gb_8=create gb_8
this.gb_9=create gb_9
this.gb_10=create gb_10
this.gb_11=create gb_11
this.dw_informe=create dw_informe
this.dw_stock_bases=create dw_stock_bases
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.em_fdesde
this.Control[iCurrent+5]=this.em_fhasta
this.Control[iCurrent+6]=this.cbx_pruebas_finalizadas
this.Control[iCurrent+7]=this.uo_tecnico
this.Control[iCurrent+8]=this.p_imagen
this.Control[iCurrent+9]=this.sle_modelo
this.Control[iCurrent+10]=this.cb_2
this.Control[iCurrent+11]=this.gb_7
this.Control[iCurrent+12]=this.gb_2
this.Control[iCurrent+13]=this.sle_pdesde
this.Control[iCurrent+14]=this.sle_phasta
this.Control[iCurrent+15]=this.st_1
this.Control[iCurrent+16]=this.em_fdesde_fin
this.Control[iCurrent+17]=this.em_fhasta_fin
this.Control[iCurrent+18]=this.gb_3
this.Control[iCurrent+19]=this.gb_4
this.Control[iCurrent+20]=this.gb_5
this.Control[iCurrent+21]=this.uo_maquina
this.Control[iCurrent+22]=this.gb_1
this.Control[iCurrent+23]=this.gb_8
this.Control[iCurrent+24]=this.gb_9
this.Control[iCurrent+25]=this.gb_10
this.Control[iCurrent+26]=this.gb_11
this.Control[iCurrent+27]=this.dw_informe
this.Control[iCurrent+28]=this.dw_stock_bases
end on

on w_con_desticket.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.cbx_pruebas_finalizadas)
destroy(this.uo_tecnico)
destroy(this.p_imagen)
destroy(this.sle_modelo)
destroy(this.cb_2)
destroy(this.gb_7)
destroy(this.gb_2)
destroy(this.sle_pdesde)
destroy(this.sle_phasta)
destroy(this.st_1)
destroy(this.em_fdesde_fin)
destroy(this.em_fhasta_fin)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_5)
destroy(this.uo_maquina)
destroy(this.gb_1)
destroy(this.gb_8)
destroy(this.gb_9)
destroy(this.gb_10)
destroy(this.gb_11)
destroy(this.dw_informe)
destroy(this.dw_stock_bases)
end on

event ue_f5;f_control(dw_informe)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_desticket
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_desticket
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_desticket
integer y = 8
integer width = 3895
integer height = 88
end type

type pb_1 from upb_salir within w_con_desticket
integer x = 3721
integer y = 160
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_2 from upb_imprimir within w_con_desticket
integer x = 3584
integer y = 160
integer taborder = 0
boolean originalsize = false
end type

event clicked;
if dw_informe.visible then
	f_imprimir_datawindow(dw_informe)
end if

if dw_stock_bases.visible then
	f_imprimir_datawindow(dw_stock_bases)
end if
end event

type cb_1 from commandbutton within w_con_desticket
integer x = 3259
integer y = 160
integer width = 288
integer height = 96
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;if isnull(uo_maquina.em_codigo.text) or uo_maquina.em_codigo.text = "" then
	MessageBox("Atención","Debe seleccionar la Máquina para realizar la consulta")
	return
end if

if dw_informe.visible then
	f_control(dw_informe)
end if

if dw_stock_bases.visible then
	f_control2 (dw_stock_bases)
end if

end event

type em_fdesde from u_em_campo within w_con_desticket
integer x = 55
integer y = 160
integer width = 361
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type em_fhasta from u_em_campo within w_con_desticket
integer x = 421
integer y = 160
integer width = 361
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type cbx_pruebas_finalizadas from checkbox within w_con_desticket
integer x = 859
integer y = 324
integer width = 709
integer height = 68
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Ver pruebas finalizadas."
borderstyle borderstyle = styleraised!
end type

event clicked;if this.checked then
	em_fdesde_fin.enabled = true
	em_fhasta_fin.enabled = true
else
	em_fdesde_fin.enabled = false
	em_fhasta_fin.enabled = false
end if
end event

type uo_tecnico from u_em_campo_2 within w_con_desticket
integer x = 1641
integer y = 316
integer width = 1106
integer taborder = 80
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;string des_tecnico

select descripcion
into :des_tecnico
from tecnico_lab
where empresa = :codigo_empresa
and codigo = :uo_tecnico.em_codigo.text;

uo_tecnico.em_campo.text = des_tecnico
If Trim(uo_tecnico.em_campo.text)="" then
	uo_tecnico.em_campo.text=""
	uo_tecnico.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Técnicos de Laboratorio"
ue_datawindow ="dw_ayuda_tecnicos_lab"
ue_filtro = ""
end event

on uo_tecnico.destroy
call u_em_campo_2::destroy
end on

type p_imagen from picture within w_con_desticket
integer x = 3954
integer y = 80
integer width = 1115
integer height = 340
boolean bringtotop = true
boolean originalsize = true
boolean focusrectangle = false
end type

type sle_modelo from singlelineedit within w_con_desticket
integer x = 2226
integer y = 164
integer width = 530
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_con_desticket
integer x = 2825
integer y = 160
integer width = 425
integer height = 96
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stock / Pruebas"
end type

event clicked;dw_stock_bases.visible = not dw_stock_bases.visible
dw_informe.visible =  not dw_informe.visible

end event

type gb_7 from groupbox within w_con_desticket
integer x = 1618
integer y = 108
integer width = 571
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Pruebas"
end type

type gb_2 from groupbox within w_con_desticket
integer x = 2199
integer y = 108
integer width = 585
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Modelo"
end type

type sle_pdesde from singlelineedit within w_con_desticket
integer x = 1646
integer y = 164
integer width = 219
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_phasta from singlelineedit within w_con_desticket
integer x = 1934
integer y = 164
integer width = 224
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_con_desticket
integer x = 1865
integer y = 176
integer width = 59
integer height = 60
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fdesde_fin from u_em_campo within w_con_desticket
integer x = 55
integer y = 320
integer width = 361
integer taborder = 100
boolean bringtotop = true
fontcharset fontcharset = ansi!
boolean enabled = false
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type em_fhasta_fin from u_em_campo within w_con_desticket
integer x = 421
integer y = 320
integer width = 361
integer taborder = 110
boolean bringtotop = true
fontcharset fontcharset = ansi!
boolean enabled = false
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type gb_3 from groupbox within w_con_desticket
integer x = 1614
integer y = 260
integer width = 1170
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Técnico"
end type

type gb_4 from groupbox within w_con_desticket
integer x = 23
integer y = 104
integer width = 782
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha Pueba"
end type

type gb_5 from groupbox within w_con_desticket
integer x = 23
integer y = 264
integer width = 782
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha fin Pueba"
end type

type uo_maquina from u_em_campo_2 within w_con_desticket
integer x = 850
integer y = 160
integer width = 727
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;string des_maquina

select descripcion
into :des_maquina
from tipomaquina_disenyo
where empresa = :codigo_empresa
and codigo = :uo_maquina.em_codigo.text;

uo_maquina.em_campo.text = des_maquina
If Trim(uo_maquina.em_campo.text)="" then
	uo_maquina.em_campo.text=""
	uo_maquina.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Técnicos de Laboratorio"
ue_datawindow ="dw_ayuda_tecnicos_lab"
ue_filtro = ""
end event

on uo_maquina.destroy
call u_em_campo_2::destroy
end on

event busqueda;str_parametros param
String consulta_busqueda
str_wt_busquedas_entrada busqueda
str_wt_busquedas_salida resultado
Int numero_valores

IF IsNull(ue_datawindow) or Trim(ue_datawindow)="" Then Return
   param.s_titulo_ventana   =  ue_titulo
   param.s_nom_datawindow   =  ue_datawindow
   param.s_filtro           =  ue_filtro
   param.b_empresa          =  valor_empresa
   This.em_codigo.text      =  Trim(ue_valor)
   This.em_campo.text       =  ""
   
	
	consulta_busqueda =     "  SELECT tipomaquina_disenyo.codigo, tipomaquina_disenyo.descripcion "+&
									"  FROM   tipomaquina_disenyo   "+&
									"  WHERE  tipomaquina_disenyo.empresa = '"+codigo_empresa+"' AND tipomaquina_disenyo.codigo NOT IN ('3') "+&
									"  ORDER BY tipomaquina_disenyo.descripcion ASC  "
		
		
	busqueda.consulta = consulta_busqueda
	busqueda.titulos[1] = "Código"
	busqueda.titulos[2] = "Descripción"
		
	OpenWithParm(wt_busquedas, busqueda)
	resultado = Message.PowerObjectParm
	if resultado.resultado = -1 then
		MessageBox("Error en la creación de la búsqueda",resultado.error)
		em_campo.text = ""
	elseif resultado.resultado > 0 then				
		em_codigo.text = resultado.valores[1]
		em_campo.text = resultado.valores[2]
	else
		em_codigo.text = ""
		em_campo.text = ""
	end if
	
	//f_buscar(This.em_codigo,param)
	
	
	
   This.TriggerEvent("modificado")
	ue_valor_anterior = Trim(em_campo.text)
//	ue_campo.SetFocus()
	ue_campo.SelectText(1,Len(ue_campo.Text))
end event

type gb_1 from groupbox within w_con_desticket
integer x = 1614
integer y = 260
integer width = 782
integer height = 160
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Técnico"
end type

type gb_8 from groupbox within w_con_desticket
integer x = 823
integer y = 104
integer width = 782
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Máquina"
end type

type gb_9 from groupbox within w_con_desticket
integer x = 823
integer y = 108
integer width = 782
integer height = 160
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Técnico"
end type

type gb_10 from groupbox within w_con_desticket
integer x = 3913
integer y = 24
integer width = 1207
integer height = 412
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Imagen Modelo Seleccionado"
end type

type gb_11 from groupbox within w_con_desticket
integer x = 2807
integer y = 112
integer width = 1074
integer height = 160
integer taborder = 110
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_informe from datawindow within w_con_desticket
integer x = 9
integer y = 440
integer width = 5111
integer height = 3136
string dataobject = "dw_listado_destickets"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;integer exito
string filtro

if dwo.name = "b_fin" then
	dw_informe.object.desticket_fecha_fin[row] = datetime (today())
	connect using SQLCA;
	exito = dw_informe.update()
	if exito = 1 then
		commit using SQLCA;
	else 
		messagebox ("Error", " No se pudo actualizar la fecha")
		rollback using SQLCA;
	end if
end if


IF dwo.name= "t_prueba" Then
//	this.SetSort("dec (desticket_codigo) A")
	this.SetSort("long (desticket_codigo) A")	
	this.Sort()
END IF

IF dwo.name= "t_p" Then
	this.SetSort("desticket_pantallas A")
	this.Sort()
END IF

IF dwo.name= "t_u" Then
	this.SetSort("desticket_urgente A")
	this.Sort()
END IF

IF dwo.name= "t_esmalte" Then
	this.SetSort("desticket_esmalte A")
	this.Sort()
END IF

IF dwo.name= "t_base" Then
	this.SetSort("articulos_descripcion A")
	this.Sort()
END IF

IF dwo.name= "t_formato" Then
	this.SetSort("articulos_ancho, articulos_largo A")
	this.Sort()
END IF

IF dwo.name= "t_tecnico" Then
	this.SetSort("tecnico_lab_descripcion A")
	this.Sort()
END IF


end event

event doubleclicked;str_parametros lstr_param 
lstr_param.i_nargumentos=2
lstr_param.s_argumentos[1]="w_con_desticket"
lstr_param.s_argumentos[2]=String(dw_informe.GetItemString(This.GetRow(),"desticket_codigo"))


OpenWithParm(w_mant_ticket_inkcid,lstr_param)
	
	
	

end event

event rowfocuschanged;This.SelectRow(0, FALSE)	
This.SelectRow ( currentrow, True )

p_imagen.PictureName = ""
IF dw_informe.GetRow() > 0 then
	p_imagen.PictureName = f_cargar_imagen_nuevo(string(dw_informe.object.desticket_modelo[dw_informe.GetRow()]))
else
	p_imagen.PictureName = ""
END IF

end event

type dw_stock_bases from datawindow within w_con_desticket
boolean visible = false
integer x = 9
integer y = 440
integer width = 5111
integer height = 3148
integer taborder = 150
string title = "none"
string dataobject = "dw_stock_bases"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

