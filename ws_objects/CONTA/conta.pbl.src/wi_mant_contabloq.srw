$PBExportHeader$wi_mant_contabloq.srw
forward
global type wi_mant_contabloq from wi_mvent_con_empresa
end type
end forward

global type wi_mant_contabloq from wi_mvent_con_empresa
integer width = 2843
integer height = 1300
end type
global wi_mant_contabloq wi_mant_contabloq

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();dw_1.Retrieve(Integer(sle_valor.Text),codigo_empresa)
end subroutine

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "contabloq"

f_control()

string in_incidencia

in_incidencia = "Año: "+sle_valor.text+" Abiertos: "
if dw_1.rowcount() > 0 then
	if dw_1.object.enero[dw_1.Getrow()] = 1 then
		in_incidencia = in_incidencia + "1 "
	end if
	if dw_1.object.Febrero[dw_1.Getrow()] = 1 then
		in_incidencia = in_incidencia + "2 "
	end if
	if dw_1.object.Marzo[dw_1.Getrow()] = 1 then
		in_incidencia = in_incidencia + "3 "
	end if
	if dw_1.object.Abril[dw_1.Getrow()] = 1 then
		in_incidencia = in_incidencia + "4 "
	end if
	if dw_1.object.Mayo[dw_1.Getrow()] = 1 then
		in_incidencia = in_incidencia + "5 "
	end if
	if dw_1.object.Junio[dw_1.Getrow()] = 1 then
		in_incidencia = in_incidencia + "6 "
	end if
	if dw_1.object.Julio[dw_1.Getrow()] = 1 then
		in_incidencia = in_incidencia + "7 "
	end if
	if dw_1.object.Agosto[dw_1.Getrow()] = 1 then
		in_incidencia = in_incidencia + "8 "
	end if
	if dw_1.object.septiembre[dw_1.Getrow()] = 1 then
		in_incidencia = in_incidencia + "9 "
	end if
	if dw_1.object.Octubre[dw_1.Getrow()] = 1 then
		in_incidencia = in_incidencia + "10 "
	end if
	if dw_1.object.Noviembre[dw_1.Getrow()] = 1 then
		in_incidencia = in_incidencia + "11 "
	end if
	if dw_1.object.Diciembre[dw_1.Getrow()] = 1 then
		in_incidencia = in_incidencia + "12 "
	end if
		
	
	f_grabar_incidencia("Meses cerrados",in_incidencia)
end if
CALL Super::ue_recuperar
end event

event open;call super::open;

istr_parametros.s_titulo_ventana  = "Mantenimiento meses cerrados"
istr_parametros.s_listado         = "report_contabloq"
This.title = istr_parametros.s_titulo_ventana

  
// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
	This.triggerEvent("ue_recuperar")
	END IF
END IF


end event

event ue_inserta_fila;call super::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"ejercicio",Integer(sle_valor.text))
 dw_1.setitem(dw_1.getrow(),"enero",0)
 dw_1.setitem(dw_1.getrow(),"febrero",0)
 dw_1.setitem(dw_1.getrow(),"marzo",0)
 dw_1.setitem(dw_1.getrow(),"abril",0)
 dw_1.setitem(dw_1.getrow(),"mayo",0)
 dw_1.setitem(dw_1.getrow(),"junio",0)
 dw_1.setitem(dw_1.getrow(),"julio",0)
 dw_1.setitem(dw_1.getrow(),"agosto",0)
 dw_1.setitem(dw_1.getrow(),"septiembre",0)
 dw_1.setitem(dw_1.getrow(),"octubre",0)
 dw_1.setitem(dw_1.getrow(),"noviembre",0)
 dw_1.setitem(dw_1.getrow(),"diciembre",0)


end event

on wi_mant_contabloq.create
call super::create
end on

on wi_mant_contabloq.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_contabloq
integer x = 59
integer y = 320
integer width = 2199
integer height = 744
string dataobject = "dw_contabloq"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_contabloq
integer x = 123
integer y = 224
integer width = 302
string text = "Ejercicio:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_contabloq
integer x = 2295
integer y = 332
end type

event cb_insertar::clicked;string ejer_activo
int ejercicio

//ejercicio = integer(sle_valor.text)
//
//select activo
//into :ejer_Activo
//from contaparam
//where empresa = :codigo_empresa
//and ejercicio = :ejercicio;
//
//
//if ejer_activo = 'N' then
//	messagebox('No va a poder ser', "El ejercicio no esta activo", stopsign!)
//	dw_1.object.enero[dw_1.getrow()] = 0
//	dw_1.object.febrero[dw_1.getrow()] = 0
//	dw_1.object.marzo[dw_1.getrow()] = 0
//	dw_1.object.abril[dw_1.getrow()] = 0
//	dw_1.object.mayo[dw_1.getrow()] = 0
//	dw_1.object.junio[dw_1.getrow()] = 0
//	dw_1.object.julio[dw_1.getrow()] = 0
//	dw_1.object.agosto[dw_1.getrow()] = 0
//	dw_1.object.septiembre[dw_1.getrow()] = 0
//	dw_1.object.octubre[dw_1.getrow()] = 0
//	dw_1.object.noviembre[dw_1.getrow()] = 0
//	dw_1.object.diciembre[dw_1.getrow()] = 0
//
//	return
//end if

CALL Super::clicked

end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_contabloq
integer x = 2295
integer y = 452
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_contabloq
integer x = 453
end type

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_contabloq
integer x = 2295
integer y = 572
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_contabloq
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_contabloq
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_contabloq
integer width = 2834
end type

