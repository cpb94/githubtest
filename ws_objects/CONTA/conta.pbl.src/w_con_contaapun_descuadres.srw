$PBExportHeader$w_con_contaapun_descuadres.srw
$PBExportComments$€
forward
global type w_con_contaapun_descuadres from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_contaapun_descuadres
end type
type uo_ejercicio from u_ejercicio within w_con_contaapun_descuadres
end type
type dw_1 from datawindow within w_con_contaapun_descuadres
end type
type cb_1 from u_boton within w_con_contaapun_descuadres
end type
type dw_listado from datawindow within w_con_contaapun_descuadres
end type
type pb_2 from upb_imprimir within w_con_contaapun_descuadres
end type
type gb_1 from groupbox within w_con_contaapun_descuadres
end type
type cb_2 from commandbutton within w_con_contaapun_descuadres
end type
end forward

global type w_con_contaapun_descuadres from w_int_con_empresa
integer width = 2935
integer height = 2228
pb_1 pb_1
uo_ejercicio uo_ejercicio
dw_1 dw_1
cb_1 cb_1
dw_listado dw_listado
pb_2 pb_2
gb_1 gb_1
cb_2 cb_2
end type
global w_con_contaapun_descuadres w_con_contaapun_descuadres

event open;call super::open;   dw_1.SetTransObject(SQLCA)
   istr_parametros.s_titulo_ventana  = "Consulta asientos descuadrados"
	istr_parametros.s_listado         = ""
   This.title = istr_parametros.s_titulo_ventana
    uo_ejercicio.em_ejercicio.text=String(f_ejercicio_activo(codigo_empresa))


end event

on w_con_contaapun_descuadres.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.uo_ejercicio=create uo_ejercicio
this.dw_1=create dw_1
this.cb_1=create cb_1
this.dw_listado=create dw_listado
this.pb_2=create pb_2
this.gb_1=create gb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.uo_ejercicio
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.pb_2
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.cb_2
end on

on w_con_contaapun_descuadres.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.uo_ejercicio)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.dw_listado)
destroy(this.pb_2)
destroy(this.gb_1)
destroy(this.cb_2)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_contaapun_descuadres
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_contaapun_descuadres
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_contaapun_descuadres
integer x = 37
integer y = 12
integer width = 2688
end type

type pb_1 from upb_salir within w_con_contaapun_descuadres
integer x = 2734
integer y = 12
integer width = 105
integer height = 104
integer taborder = 0
end type

type uo_ejercicio from u_ejercicio within w_con_contaapun_descuadres
integer x = 2213
integer y = 168
boolean bringtotop = true
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type dw_1 from datawindow within w_con_contaapun_descuadres
integer x = 9
integer y = 284
integer width = 2834
integer height = 1696
boolean bringtotop = true
string dataobject = "dw_con_contaapun_descuadres"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros zstr_param
  	zstr_param.i_nargumentos=5
 	zstr_param.s_argumentos[2]=String(dw_1.GetitemNumber(row,"ejercicio"))
 	zstr_param.s_argumentos[3]=dw_1.GetItemString(row,"origen")
 	zstr_param.s_argumentos[4]=string(date(dw_1.GetItemDatetime(row,"fapunte")))
	zstr_param.s_argumentos[5]=string(dw_1.GetItemNumber(row,"asiento"))
  
  OpenWithParm(w_int_contaapun,zstr_param) 

end event

type cb_1 from u_boton within w_con_contaapun_descuadres
integer x = 32
integer y = 164
integer width = 430
integer height = 88
string text = "&Continuar"
end type

event clicked;dw_1.Retrieve(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa)
dw_1.SetFilter("")
dw_1.Filter()

end event

type dw_listado from datawindow within w_con_contaapun_descuadres
boolean visible = false
integer x = 1239
integer y = 4
integer width = 494
integer height = 216
boolean bringtotop = true
string dataobject = "report_con_contaapun_descuadres"
boolean livescroll = true
end type

type pb_2 from upb_imprimir within w_con_contaapun_descuadres
integer x = 466
integer y = 164
integer width = 105
integer height = 88
integer taborder = 0
boolean originalsize = false
end type

event clicked;dw_listado.SettransObject(SQLCA)
dw_listado.Retrieve(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa)
f_imprimir_datawindow(dw_listado)


end event

type gb_1 from groupbox within w_con_contaapun_descuadres
integer x = 18
integer y = 108
integer width = 567
integer height = 156
integer textsize = -14
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
end type

type cb_2 from commandbutton within w_con_contaapun_descuadres
integer x = 1518
integer y = 156
integer width = 320
integer height = 108
integer taborder = 11
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar"
end type

event clicked;long indice,total,ejercicio,mes,apunte,nuevo_apunte
long asiento,nuevo_asiento,indice2,total2
datastore dw_asiento
string sel,origen
boolean bien

dw_1.accepttext()
total =  dw_1.rowcount()

for indice = 1 to total
	asiento       = dw_1.object.asiento[indice]
	origen        = dw_1.object.origen[indice]
	ejercicio     = dw_1.object.ejercicio[indice]
	mes           = dw_1.object.mes[indice]
	nuevo_asiento = dw_1.object.nuevo_asiento[indice]
	if isnull(nuevo_asiento) then nuevo_asiento = 0
	
	if nuevo_asiento > 0 then
		if nuevo_asiento <> asiento then
			bien = true
			sel = "select apunte from contaapun "+&
					"Where empresa = '"+codigo_empresa+"' "+&
					"and origen    = '"+origen+"' "+&
					"and ejercicio = "+string(ejercicio)+" "+&
					"and mes       = "+string(mes)+" "+&
					"and asiento   = "+string(asiento)+&
					" order by apunte"
			//dw_asiento = f_cargar_cursor(sel)
			f_cargar_cursor_nuevo(sel, dw_asiento)
			total2  = dw_asiento.rowcount()
			for indice2 = 1 to total2
				apunte = dw_asiento.object.apunte[indice2]
				
				select max(apunte) 
				into :nuevo_apunte
				from contaapun
				where empresa = :codigo_empresa
				and ejercicio = :ejercicio
				and origen    = :origen
				and mes       = :mes
				and asiento   = :nuevo_asiento;
				
				if isnull(nuevo_apunte) then nuevo_apunte = 0
				nuevo_apunte ++
				
				update contaapun
				set  apunte = :nuevo_apunte,
					 asiento = :nuevo_asiento
				where empresa = :codigo_empresa
				and ejercicio = :ejercicio
				and origen    = :origen
				and mes       = :mes
				and asiento   = :asiento
				and apunte    = :apunte;
				
				if sqlca.sqlcode <> 0 then
					bien = false
				end if
			next
			if bien then
				commit;
			else
				rollback;
				messagebox("Error","Al modificar el asiento "+string(asiento))
			end if
		end if
	end if
next

destroy dw_asiento
end event

