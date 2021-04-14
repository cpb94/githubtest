$PBExportHeader$w_mant_meses.srw
forward
global type w_mant_meses from w_int_con_empresa
end type
type dw_1 from datawindow within w_mant_meses
end type
type ddlb_mes from dropdownlistbox within w_mant_meses
end type
type cb_generar from commandbutton within w_mant_meses
end type
type uo_calendario from u_em_campo_2 within w_mant_meses
end type
type gb_7 from groupbox within w_mant_meses
end type
type gb_6 from groupbox within w_mant_meses
end type
type gb_5 from groupbox within w_mant_meses
end type
type r_1 from rectangle within w_mant_meses
end type
type cb_grabar from commandbutton within w_mant_meses
end type
type cb_6 from commandbutton within w_mant_meses
end type
type sle_horas from singlelineedit within w_mant_meses
end type
type r_2 from rectangle within w_mant_meses
end type
type r_3 from rectangle within w_mant_meses
end type
type r_4 from rectangle within w_mant_meses
end type
type cb_borrar from commandbutton within w_mant_meses
end type
type cb_1 from commandbutton within w_mant_meses
end type
type em_anyo from editmask within w_mant_meses
end type
type cbx_fin_semana from checkbox within w_mant_meses
end type
end forward

global type w_mant_meses from w_int_con_empresa
integer x = 471
integer y = 4
integer width = 2848
integer height = 2556
dw_1 dw_1
ddlb_mes ddlb_mes
cb_generar cb_generar
uo_calendario uo_calendario
gb_7 gb_7
gb_6 gb_6
gb_5 gb_5
r_1 r_1
cb_grabar cb_grabar
cb_6 cb_6
sle_horas sle_horas
r_2 r_2
r_3 r_3
r_4 r_4
cb_borrar cb_borrar
cb_1 cb_1
em_anyo em_anyo
cbx_fin_semana cbx_fin_semana
end type
global w_mant_meses w_mant_meses

forward prototypes
public function integer f_numero_mes (string mes)
end prototypes

public function integer f_numero_mes (string mes);integer var_mes

if mes <> "" then
	choose case ddlb_mes.text
		case "Enero"
			var_mes = 1
		case "Febrero"
			var_mes = 2
		case "Marzo"
			var_mes = 3
		case "Abril"
			var_mes = 4
		case "Mayo"
			var_mes = 5
		case "Junio"
			var_mes = 6
		case "Julio"
			var_mes = 7
		case "Agosto"
			var_mes = 8
		case "Septiembre"
			var_mes = 9
		case "Octubre"
			var_mes = 10
		case "Noviembre"
			var_mes = 11
		case "Diciembre"
			var_mes = 12
	end choose
end if	

return var_mes

end function

on w_mant_meses.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.ddlb_mes=create ddlb_mes
this.cb_generar=create cb_generar
this.uo_calendario=create uo_calendario
this.gb_7=create gb_7
this.gb_6=create gb_6
this.gb_5=create gb_5
this.r_1=create r_1
this.cb_grabar=create cb_grabar
this.cb_6=create cb_6
this.sle_horas=create sle_horas
this.r_2=create r_2
this.r_3=create r_3
this.r_4=create r_4
this.cb_borrar=create cb_borrar
this.cb_1=create cb_1
this.em_anyo=create em_anyo
this.cbx_fin_semana=create cbx_fin_semana
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.ddlb_mes
this.Control[iCurrent+3]=this.cb_generar
this.Control[iCurrent+4]=this.uo_calendario
this.Control[iCurrent+5]=this.gb_7
this.Control[iCurrent+6]=this.gb_6
this.Control[iCurrent+7]=this.gb_5
this.Control[iCurrent+8]=this.r_1
this.Control[iCurrent+9]=this.cb_grabar
this.Control[iCurrent+10]=this.cb_6
this.Control[iCurrent+11]=this.sle_horas
this.Control[iCurrent+12]=this.r_2
this.Control[iCurrent+13]=this.r_3
this.Control[iCurrent+14]=this.r_4
this.Control[iCurrent+15]=this.cb_borrar
this.Control[iCurrent+16]=this.cb_1
this.Control[iCurrent+17]=this.em_anyo
this.Control[iCurrent+18]=this.cbx_fin_semana
end on

on w_mant_meses.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.ddlb_mes)
destroy(this.cb_generar)
destroy(this.uo_calendario)
destroy(this.gb_7)
destroy(this.gb_6)
destroy(this.gb_5)
destroy(this.r_1)
destroy(this.cb_grabar)
destroy(this.cb_6)
destroy(this.sle_horas)
destroy(this.r_2)
destroy(this.r_3)
destroy(this.r_4)
destroy(this.cb_borrar)
destroy(this.cb_1)
destroy(this.em_anyo)
destroy(this.cbx_fin_semana)
end on

event open;call super::open;integer permiso

permiso = f_permiso_usuario(this.classname(), nombre_usuario)
choose case  permiso
	case 1
		cb_grabar.visible = false
		cb_borrar.visible = false
		cb_generar.visible = false
end choose

dw_1.SetTransObject (SQLCA)


em_anyo.text = String(Year(Today()))

end event

event activate;call super::activate;w_mant_meses = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_mant_meses
integer taborder = 60
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_mant_meses
end type

type st_empresa from w_int_con_empresa`st_empresa within w_mant_meses
integer x = 27
integer y = 16
integer width = 2784
integer height = 92
integer textsize = -12
end type

type dw_1 from datawindow within w_mant_meses
integer x = 1915
integer y = 260
integer width = 869
integer height = 2028
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_meses"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type ddlb_mes from dropdownlistbox within w_mant_meses
integer x = 1915
integer y = 160
integer width = 869
integer height = 808
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;integer mes

mes = f_numero_mes (ddlb_mes.text)			
dw_1.Retrieve (codigo_empresa, uo_calendario.em_codigo.text, integer(em_anyo.text), mes)

end event

type cb_generar from commandbutton within w_mant_meses
integer x = 654
integer y = 1156
integer width = 411
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Generar"
end type

event clicked;datetime fecha_actual, fecha_cal
integer v_anyo, v_mes, v_dia, mes, i
string v_calendario, dia_nombre
decimal v_horas
boolean fallo = false


fecha_Actual = datetime(date('01/01/'+em_anyo.text))

i = 0
DO WHILE  fecha_actual <> datetime(date('01/01/'+string(integer(em_anyo.text)+1)))
	i = i+1
	fecha_actual = datetime(RelativeDate (date(fecha_actual), 1 ))
	v_anyo = integer(em_anyo.text)
	v_mes = month(date(fecha_actual))
	v_dia = day(date(fecha_actual))
	v_calendario = uo_calendario.em_codigo.text
	v_horas = integer(sle_horas.text)
	fecha_cal = datetime(date(v_anyo, v_mes, v_dia ))
	
	dia_nombre = dayname( date(fecha_cal) )
	if cbx_fin_semana.checked and (dia_nombre = "Saturday" or dia_nombre = "Sunday") then 
		v_horas = 0
	end if
	
	insert into prodmeses (empresa, anyo, mes, dia, calendario, horas, fecha)
	values ( :codigo_empresa, :v_anyo, :v_mes, :v_dia, :v_calendario, :v_horas, :fecha_cal);

	if SQLCA.SQLCode <> 0 then
		fallo = true
	end if

	f_mensaje_proceso ("Generando Calendario", i, 365) 
LOOP

if fallo then
	messagebox ("Error","No se pudo generar el calendario")
	rollback;
else
	messagebox ("Aviso","El Calendario se ha generado con éxito")
	commit;
	mes = f_numero_mes (ddlb_mes.text)			
	dw_1.Retrieve(codigo_empresa, uo_calendario.em_codigo.text, integer(em_anyo.text), mes)
end if





end event

type uo_calendario from u_em_campo_2 within w_mant_meses
event destroy ( )
integer x = 64
integer y = 220
integer width = 1381
integer height = 68
integer taborder = 10
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_calendario.destroy
call u_em_campo_2::destroy
end on

event modificado;string des_calendario
integer mes

select descripcion
into :des_calendario
from prodcalendarios
where codigo = :uo_calendario.em_codigo.text;

uo_calendario.em_campo.text = des_calendario
IF Trim(uo_calendario.em_campo.text)="" THEN 
 IF Trim(uo_calendario.em_codigo.text)<>"" Then uo_calendario.em_campo.SetFocus()
 uo_calendario.em_campo.text=""
 uo_calendario.em_codigo.text=""
END IF

mes = f_numero_mes (ddlb_mes.text)			
dw_1.Retrieve(codigo_empresa, uo_calendario.em_codigo.text, integer(em_anyo.text), mes)



end event

event getfocus;call super::getfocus;valor_empresa = false
ue_titulo     = "Ayuda seleccion de Calendarios"
ue_datawindow = "dw_ayuda_calendarios"
ue_filtro     = ""

end event

type gb_7 from groupbox within w_mant_meses
integer x = 622
integer y = 1096
integer width = 645
integer height = 176
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Horas"
end type

type gb_6 from groupbox within w_mant_meses
integer x = 1481
integer y = 164
integer width = 370
integer height = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Año"
end type

type gb_5 from groupbox within w_mant_meses
integer x = 41
integer y = 164
integer width = 1431
integer height = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Calendario"
end type

type r_1 from rectangle within w_mant_meses
long linecolor = 12632256
integer linethickness = 4
long fillcolor = 8421376
integer x = 1897
integer y = 148
integer width = 905
integer height = 2160
end type

type cb_grabar from commandbutton within w_mant_meses
integer x = 649
integer y = 636
integer width = 613
integer height = 96
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Grabar"
end type

event clicked;dw_1.Update()

end event

type cb_6 from commandbutton within w_mant_meses
integer x = 649
integer y = 536
integer width = 613
integer height = 96
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;close(parent)
end event

type sle_horas from singlelineedit within w_mant_meses
integer x = 1070
integer y = 1156
integer width = 165
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type r_2 from rectangle within w_mant_meses
long linecolor = 12632256
integer linethickness = 4
long fillcolor = 8388736
integer x = 626
integer y = 520
integer width = 649
integer height = 324
end type

type r_3 from rectangle within w_mant_meses
long linecolor = 12632256
integer linethickness = 4
long fillcolor = 8421376
integer x = 599
integer y = 1080
integer width = 690
integer height = 208
end type

type r_4 from rectangle within w_mant_meses
long linecolor = 12632256
integer linethickness = 4
long fillcolor = 33554432
integer x = 23
integer y = 148
integer width = 1847
integer height = 176
end type

type cb_borrar from commandbutton within w_mant_meses
integer x = 649
integer y = 736
integer width = 613
integer height = 96
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Borrar Calendario"
end type

event clicked;integer v_anyo
string v_calendario

v_anyo = integer(em_anyo.text)
v_calendario = uo_calendario.em_codigo.text

if Messagebox ("Aviso", "¿Seguro que desea borrar el calendario?", Exclamation!, YesNo!, 2) = 1 then
	delete from prodmeses 
	where empresa = :codigo_empresa 
	and anyo = :v_anyo
	and calendario = :v_calendario;
end if

if SQLCA.SQLCode = 0 then
	commit;
	Messagebox ("Aviso", "Se ha borrado el calendario", Exclamation!, OK!) 
	dw_1.Reset()
else
	rollback;
	Messagebox ("Aviso", "No se ha podido borrar el calendario", Exclamation!, OK!) 

end if





end event

type cb_1 from commandbutton within w_mant_meses
boolean visible = false
integer x = 581
integer y = 1768
integer width = 709
integer height = 84
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar Fecha Completa"
end type

event clicked;string usuario_sql, sel
datastore regs
sel =  ' SELECT convert(char(30), CURRENT_USER) usuario'

f_cargar_cursor_nuevo (sel, regs )
usuario_sql = regs.object.usuario[1]
messagebox ("" , usuario_sql)
destroy regs

//date fecha_actual, fecha_cal
//integer v_anyo, v_mes, v_dia, mes, i
//string v_calendario
//decimal v_horas
//boolean fallo = false
//datastore regs
//string sel
//
//fecha_Actual = date('01/01/'+ddlb_anyo.text)
//
//sel = 	" select anyo, mes, dia "+&
//			" from prodmeses "
//			
//f_cargar_cursor_nuevo (sel, regs)
//
//for i = 1 to regs.rowcount()
//	v_anyo = regs.object.anyo[i]
//	v_mes = regs.object.mes[i]
//	v_dia = regs.object.dia[i]
//	fecha_cal = date(v_anyo, v_mes, v_dia )
//	
//	update prodmeses 
//	set fecha = :fecha_cal
//	where ( empresa = :codigo_empresa and anyo = :v_anyo and mes = :v_mes and dia = :v_dia );
//
//	if SQLCA.SQLCode <> 0 then
//		fallo = true
//	end if
//		
//	f_mensaje_proceso ("Generando Calendario", i, regs.rowcount()) 
//	
//next
//		
//
//commit;
//
//
//

end event

type em_anyo from editmask within w_mant_meses
integer x = 1504
integer y = 216
integer width = 329
integer height = 72
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "#"
boolean spin = true
double increment = 1
string minmax = "~~"
end type

event modified;integer mes

mes = f_numero_mes (ddlb_mes.text)			
dw_1.Retrieve(codigo_empresa, uo_calendario.em_codigo.text, integer(this.text), mes)
end event

type cbx_fin_semana from checkbox within w_mant_meses
integer x = 599
integer y = 1308
integer width = 704
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Fines de semana 0 horas"
boolean checked = true
end type

