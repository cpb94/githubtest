$PBExportHeader$w_procesos_arreglo_costes.srw
forward
global type w_procesos_arreglo_costes from w_int_con_empresa
end type
type pb_2 from upb_salir within w_procesos_arreglo_costes
end type
type dw_listado from datawindow within w_procesos_arreglo_costes
end type
type uo_tipo2 from u_marca_lista within w_procesos_arreglo_costes
end type
type dw_proceso2 from datawindow within w_procesos_arreglo_costes
end type
type dw_1 from datawindow within w_procesos_arreglo_costes
end type
type cb_1 from commandbutton within w_procesos_arreglo_costes
end type
end forward

global type w_procesos_arreglo_costes from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2962
integer height = 1668
string title = "Consulta de Movimientos"
pb_2 pb_2
dw_listado dw_listado
uo_tipo2 uo_tipo2
dw_proceso2 dw_proceso2
dw_1 dw_1
cb_1 cb_1
end type
global w_procesos_arreglo_costes w_procesos_arreglo_costes

type variables
String ante_articulo,retrasos
end variables

event open;call super::open;This.title = " proceso arreglo apuntes de costes"
dw_1.SetTransObject(SQLCA)




end event

on w_procesos_arreglo_costes.create
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

on w_procesos_arreglo_costes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_listado)
destroy(this.uo_tipo2)
destroy(this.dw_proceso2)
destroy(this.dw_1)
destroy(this.cb_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_procesos_arreglo_costes
integer x = 489
integer y = 636
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_procesos_arreglo_costes
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_procesos_arreglo_costes
integer y = 16
integer width = 2642
end type

type pb_2 from upb_salir within w_procesos_arreglo_costes
integer x = 2725
integer y = 16
integer width = 128
integer height = 112
integer taborder = 0
string picturename = "exit!"
end type

type dw_listado from datawindow within w_procesos_arreglo_costes
boolean visible = false
integer x = 14
integer y = 72
integer width = 448
integer height = 264
boolean bringtotop = true
string dataobject = "report_con_costes"
boolean livescroll = true
end type

type uo_tipo2 from u_marca_lista within w_procesos_arreglo_costes
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

type dw_proceso2 from datawindow within w_procesos_arreglo_costes
boolean visible = false
integer x = 530
integer y = 24
integer width = 325
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_contaconcepto"
boolean livescroll = true
end type

type dw_1 from datawindow within w_procesos_arreglo_costes
integer y = 360
integer width = 2857
integer height = 1076
string dataobject = "dw_procesos_arreglo_costes"
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

type cb_1 from commandbutton within w_procesos_arreglo_costes
integer x = 1467
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

event clicked;Long i,cuantas,bien = 0
Dec{2} asien,ejer,apun,importe
String cta,prov,fra,emp,sec,subsec,ori,concep,ampli,coste
Integer mes
DateTime fecfac,fecapu

cuantas = dw_1.Retrieve()

FOR i = 1 to cuantas
	ejer    = dw_1.GetItemNumber(i,"anyo")
	emp     = dw_1.GetItemString(i,"empresa")
	cta     = dw_1.GetItemString(i,"cuenta")
	prov    = dw_1.GetItemString(i,"proveedor")
	importe = dw_1.GetItemNumber(i,"importe")
	fra     = dw_1.GetItemString(i,"factura")
	sec     = dw_1.GetItemString(i,"seccion")
	subsec  = dw_1.GetItemString(i,"subseccion")
	fecfac  = dw_1.GetItemDateTime(i,"comcabfac_fecha_fac")
	
	SELECT contaapun.mes,contaapun.origen,contaapun.asiento,
			 contaapun.apunte,contaapun.concepto,contaapun.ampliacion,
			 contaapun.fapunte
		INTO :mes,:ori,:asien,:apun,:concep,:ampli,:fecapu
		FROM contaapun
	WHERE contaapun.ejercicio = :ejer
	AND   contaapun.empresa   = :emp
	AND   contaapun.cuenta    = :cta
	AND   contaapun.documento = :fra
	AND   contaapun.ffactura  = :fecfac USING SQLCA;
	IF SQLCA.SQLCode <> 0 THEN
		MessageBox("ERROR al leer contaapun",String(cta+" "+fra+" "+String(Date(fecfac))))
		bien = 1
		EXIT
	END IF
	IF Len(sec) = 1 THEN
		sec = "00"+sec
	END IF
	coste = sec+subsec
	INSERT INTO costesapu (ejercicio,empresa,mes,origen,asiento,apunte,
								  coste,debe,haber,concepto,ampliacion,
								  cuenta,fapunte)
			VALUES			(:ejer,:emp,:mes,:ori,:asien,:apun,:coste,
								 :importe,0,:concep,:ampli,:cta,:fecapu) 
			USING SQLCA;
	
	IF SQLCA.SQLCode <> 0 THEN
		MessageBox("Error al grabar costesapu",String(asien)+" Apunte "+String(apun))
		bien = 1
		EXIT
	END IF
NEXT

IF bien = 1 THEN
	ROLLBACK;
ELSE
	COMMIT;
END IF

MessageBox("Todo Acaba","Algun dia")
end event

