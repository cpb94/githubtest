$PBExportHeader$w_procesos_arreglo_iva.srw
forward
global type w_procesos_arreglo_iva from w_int_con_empresa
end type
type pb_2 from upb_salir within w_procesos_arreglo_iva
end type
type dw_listado from datawindow within w_procesos_arreglo_iva
end type
type uo_tipo2 from u_marca_lista within w_procesos_arreglo_iva
end type
type dw_proceso2 from datawindow within w_procesos_arreglo_iva
end type
type dw_1 from datawindow within w_procesos_arreglo_iva
end type
type cb_1 from commandbutton within w_procesos_arreglo_iva
end type
end forward

global type w_procesos_arreglo_iva from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2967
integer height = 1664
string title = "Consulta de Movimientos"
pb_2 pb_2
dw_listado dw_listado
uo_tipo2 uo_tipo2
dw_proceso2 dw_proceso2
dw_1 dw_1
cb_1 cb_1
end type
global w_procesos_arreglo_iva w_procesos_arreglo_iva

type variables
String ante_articulo,retrasos
end variables

event open;call super::open;This.title = " proceso arreglo apuntes"
dw_1.SetTransObject(SQLCA)




end event

on w_procesos_arreglo_iva.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_listado=create dw_listado
this.uo_tipo2=create uo_tipo2
this.dw_proceso2=create dw_proceso2
this.dw_1=create dw_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_listado
this.Control[iCurrent+3]=this.uo_tipo2
this.Control[iCurrent+4]=this.dw_proceso2
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.cb_1
end on

on w_procesos_arreglo_iva.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_listado)
destroy(this.uo_tipo2)
destroy(this.dw_proceso2)
destroy(this.dw_1)
destroy(this.cb_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_procesos_arreglo_iva
integer x = 489
integer y = 636
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_procesos_arreglo_iva
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_procesos_arreglo_iva
integer y = 16
integer width = 2642
end type

type pb_2 from upb_salir within w_procesos_arreglo_iva
integer x = 2725
integer y = 16
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type dw_listado from datawindow within w_procesos_arreglo_iva
boolean visible = false
integer x = 14
integer y = 72
integer width = 448
integer height = 264
boolean bringtotop = true
string dataobject = "report_con_costes"
boolean livescroll = true
end type

type uo_tipo2 from u_marca_lista within w_procesos_arreglo_iva
boolean visible = false
integer x = 1435
integer y = 364
integer width = 1454
integer height = 652
boolean border = false
end type

on uo_tipo2.destroy
call u_marca_lista::destroy
end on

type dw_proceso2 from datawindow within w_procesos_arreglo_iva
boolean visible = false
integer x = 530
integer y = 24
integer width = 325
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_contaconcepto"
boolean livescroll = true
end type

type dw_1 from datawindow within w_procesos_arreglo_iva
integer y = 360
integer width = 2857
integer height = 1076
string dataobject = "dw_procesos_arreglo_iva"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;	str_parametros zstr_param
  	zstr_param.i_nargumentos=5
 	zstr_param.s_argumentos[2]=String(dw_1.GetitemNumber(row,"contaapun_ejercicio"))
 	zstr_param.s_argumentos[3]=dw_1.GetItemString(row,"contaapun_origen")
 	zstr_param.s_argumentos[4]=string(date(dw_1.GetItemDatetime(row,"fapunte")))
	zstr_param.s_argumentos[5]=string(dw_1.GetItemNumber(row,"asiento"))
  
  OpenWithParm(w_int_contaapun,zstr_param) 

end event

type cb_1 from commandbutton within w_procesos_arreglo_iva
integer x = 1477
integer y = 192
integer width = 325
integer height = 108
integer taborder = 1
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Comenzar"
end type

event clicked;Long i,cuantas,tantas,p
Dec{2} asto,ejer,apun,asien
String cta,doc,prov,fra,tipter,orig,nomprov,emp,ampli,s_asto
Integer mes,mesnuevo
Datetime fecfin,fecreg

fecfin = Datetime(date("28/12/97"))
fecreg = Datetime(date("31/12/97"))

cuantas = dw_1.Retrieve(fecfin)

FOR i = 1 to cuantas
	ejer  = dw_1.GetItemNumber(i,"ejercicio")
	emp  = dw_1.GetItemString(i,"empresa")
	mes  = dw_1.GetItemNumber(i,"mes")
	orig  = dw_1.GetItemString(i,"origen")
	asien  = dw_1.GetItemNumber(i,"asiento")
	apun  = dw_1.GetItemNumber(i,"apunte")
//	fecreg  = dw_1.GetItemDatetime(i,"fregistro")
	mesnuevo = Month(Date(fecreg))
	
	asto = f_ultimo_asiento(ejer,emp,mesnuevo,orig)
	
	UPDATE contaapun SET contaapun.mes = :mesnuevo,
								contaapun.asiento = :asto,
								contaapun.fapunte = :fecreg,
								contaapun.fregistro = :fecreg
	WHERE contaapun.ejercicio = :ejer
	AND   contaapun.empresa = :emp
	AND   contaapun.mes 		= :mes
	AND   contaapun.origen  = :orig
	AND   contaapun.asiento = :asien USING SQLCA;
	IF SQLCA.SQLCode <> 0 THEN
		MessageBox("Error","asiento "+String(asto)+" Apunte "+String(apun))
		ROLLBACK;
	END IF
	
	UPDATE costesapu SET contaapun.mes = :mesnuevo,
								contaapun.asiento = :asto,
								contaapun.fapunte = :fecreg
	WHERE costesapu.ejercicio = :ejer
	AND   costesapu.empresa = :emp
	AND   costesapu.mes 		= :mes
	AND   costesapu.origen  = :orig
	AND   costesapu.asiento = :asien USING SQLCA;
	IF SQLCA.SQLCode <> 0 THEN
		MessageBox("Error","asiento "+String(asto)+" Apunte "+String(apun))
		ROLLBACK;
	END IF
	
NEXT
COMMIT;
MessageBox("Todo Acaba","Algun dia")
end event

