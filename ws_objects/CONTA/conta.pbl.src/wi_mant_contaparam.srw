$PBExportHeader$wi_mant_contaparam.srw
forward
global type wi_mant_contaparam from wi_mvent_con_empresa
end type
type dw_2 from datawindow within wi_mant_contaparam
end type
end forward

global type wi_mant_contaparam from wi_mvent_con_empresa
integer width = 3232
integer height = 1728
dw_2 dw_2
end type
global wi_mant_contaparam wi_mant_contaparam

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();dw_2.Retrieve(Integer(sle_valor.Text),codigo_empresa)
dw_1.Retrieve(codigo_empresa,Integer(sle_valor.Text))
end subroutine

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "contaparam"

f_control()
CALL Super::ue_recuperar
end event

event open;call super::open;   istr_parametros.s_titulo_ventana  = "Mantenimiento parametros contables"
	istr_parametros.s_listado         = "report_contaparam"
   This.title = istr_parametros.s_titulo_ventana

   sle_valor.text=String(year(today()))
   dw_2.SetTransObject(SQLCA)
	
   f_control()
 
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
         f_control()
      END IF
   END IF


	
end event

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"ejercicio",Integer(sle_valor.text))
 dw_1.setitem(dw_1.getrow(),"comienzo",today())


end on

on wi_mant_contaparam.create
int iCurrent
call super::create
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on wi_mant_contaparam.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_contaparam
integer x = 46
integer y = 196
integer width = 2766
integer height = 832
string dataobject = "dw_contaparam"
end type

event dw_1::clicked;call super::clicked;str_parametros lstr_param

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_contaparam"
CHOOSE CASE f_objeto_datawindow(dw_1)
  
CASE 'pb_iva'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tipocta_iva")
   OpenWithParm(wi_mant_contatipocta,lstr_param)  



END CHOOSE



end event

event dw_1::key; valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
   CASE "tipocta_iva"
      bus_titulo     = "VENTANA SELECCION DE TIPO DE CUENTAS "
 		bus_datawindow = "dw_ayuda_contatipocta"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 
end event

event dw_1::rbuttondown; valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
   CASE "tipocta_iva"
      bus_titulo     = "VENTANA SELECCION DE TIPO DE CUENTAS "
 		bus_datawindow = "dw_ayuda_contatipocta"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_1::valores_numericos;call super::valores_numericos;f_valores_numericos(dw_1,"tipocta_iva")

end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_contaparam
integer x = 151
integer y = 100
integer width = 302
string text = "Ejercicio:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_contaparam
integer x = 2811
integer y = 272
end type

event cb_insertar::clicked;if cb_insertar.enabled = false then 
	CALL Super::clicked
	return
end if


int ejer_actual,ejer_anterior

int cuantos,cuantos_activos
string valor_activo
cuantos = 0

ejer_actual = integer(sle_valor.text)
ejer_anterior = f_ejercicio_anterior(ejer_actual)




// Valor en campo ejercicio activo 
valor_activo = dw_1.getitemstring(1,"activo")
// Si es S comprobamos		
if (valor_activo = "s") or (valor_activo ="S") then
	cuantos_activos = f_comprueba_ejer_act(ejer_actual)
	// Sólo puede haber uno activo
	if cuantos_activos >0 then 
		messagebox("Atención","Ya existe un ejercicio activo, " +&
						"Para que éste sea el activo debe dar de baja el anterior ")
		dw_1.setitem(1,"activo","N")
		
		return				
	end  if  


end if



// Comprobación de si ya existe el ejercicio
select count(*) into :cuantos
from   contaparam
where (empresa = :codigo_empresa) and
		(ejercicio = :ejer_actual);

int resultado1,resultado2,resultado3,resultado4,resultado5
resultado1 = 0
resultado2 = 0
resultado3 = 0
resultado4 = 0
resultado5 = 0

setpointer(hourglass!)

//	Si no existe y hay ejercicio anterior copiamos las tablas del ejercicio anterior
if (cuantos <= 0 ) and (ejer_anterior > 1) then
   
	// Copiamos plan contable del ejercicio anterior	
	resultado1 = f_copiar_plan(ejer_anterior,ejer_actual)
	
	// Copiamos libros de IVA
	resultado2 = f_copiar_libros_iva(ejer_anterior,ejer_actual)
	
	// Copiamos tipos de IVA
	resultado3 = f_cop_tip_iva_gno(codigo_empresa,ejer_anterior,ejer_actual,'contaiva')//f_cop_tip_iva(ejer_anterior,ejer_actual)
	
	// Copiamos asientos recurrentes
	resultado4 = f_copia_as_rec(ejer_anterior,ejer_actual)
	
	
	// Copiamos lineas de los asientos recurrentes
	resultado5 = f_copia_lin_asrec(ejer_anterior,ejer_actual)
	
	
	
	// si todo bien
	if (resultado1=1) and (resultado2=1) and & 
		(resultado3=1) and (resultado4 = 1) and (resultado5= 1) then
		commit;
		messagebox("Atención","Se copiaron con éxito desde el ejercicio anterior "+ &
						+ "los datos de : " + & 
						+ "libros de IVA, Plan contable, Tipos de IVA y Asientos recurrentes")
	else
		// Si falla alguno volvemos atrás
		rollback;
		messagebox("Atención","No se pudo copiar desde el ejercicio anterior " + &
						"los datos de : " + & 
						+ "libros de IVA, Plan contable, Tipos de IVA y Asientos Recurrentes. " +&
						"Puede que no exista ejercicio anterior o no tenga estos datos" )
	end if
	
end if

setpointer(arrow!)

CALL Super::clicked
  


end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_contaparam
integer x = 2811
integer y = 392
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_contaparam
integer x = 480
integer y = 88
end type

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_contaparam
integer x = 2811
integer y = 516
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_contaparam
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_contaparam
integer y = 80
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_contaparam
integer width = 2834
end type

type dw_2 from datawindow within wi_mant_contaparam
integer x = 41
integer y = 1068
integer width = 2414
integer height = 440
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Parametros por libros de iva"
string dataobject = "dw_contaparam2"
boolean vscrollbar = true
end type

