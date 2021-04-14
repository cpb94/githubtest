$PBExportHeader$w_int_simul_remesas_expor_original.srw
$PBExportComments$€
forward
global type w_int_simul_remesas_expor_original from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_simul_remesas_expor_original
end type
type dw_listado from datawindow within w_int_simul_remesas_expor_original
end type
type st_remesa from statictext within w_int_simul_remesas_expor_original
end type
type em_remesa from u_em_campo within w_int_simul_remesas_expor_original
end type
type em_fecharemesa from u_em_campo within w_int_simul_remesas_expor_original
end type
type cb_continuar from commandbutton within w_int_simul_remesas_expor_original
end type
type pb_imp_recibos from upb_imprimir within w_int_simul_remesas_expor_original
end type
type gb_2 from groupbox within w_int_simul_remesas_expor_original
end type
type gb_1 from groupbox within w_int_simul_remesas_expor_original
end type
type em_vto_desde from editmask within w_int_simul_remesas_expor_original
end type
type cb_marcar from u_cancelar within w_int_simul_remesas_expor_original
end type
type cb_desmarca from u_cancelar within w_int_simul_remesas_expor_original
end type
type dw_remesas from datawindow within w_int_simul_remesas_expor_original
end type
type dw_recibos from datawindow within w_int_simul_remesas_expor_original
end type
type st_2 from statictext within w_int_simul_remesas_expor_original
end type
type em_vto_hasta from editmask within w_int_simul_remesas_expor_original
end type
type st_6 from statictext within w_int_simul_remesas_expor_original
end type
type st_7 from statictext within w_int_simul_remesas_expor_original
end type
type st_9 from statictext within w_int_simul_remesas_expor_original
end type
type st_11 from statictext within w_int_simul_remesas_expor_original
end type
type cb_retrocede from commandbutton within w_int_simul_remesas_expor_original
end type
type st_banco from statictext within w_int_simul_remesas_expor_original
end type
type uo_banco from u_em_campo_2 within w_int_simul_remesas_expor_original
end type
type cb_salir from commandbutton within w_int_simul_remesas_expor_original
end type
type cb_ejecuta from commandbutton within w_int_simul_remesas_expor_original
end type
type cb_bancos from commandbutton within w_int_simul_remesas_expor_original
end type
type dw_bancos from datawindow within w_int_simul_remesas_expor_original
end type
type dw_lgasban from datawindow within w_int_simul_remesas_expor_original
end type
type uo_bancorem from u_em_campo_2 within w_int_simul_remesas_expor_original
end type
type st_3 from statictext within w_int_simul_remesas_expor_original
end type
type dw_gastos from datawindow within w_int_simul_remesas_expor_original
end type
type dw_detalle from datawindow within w_int_simul_remesas_expor_original
end type
type st_imp_recibos from statictext within w_int_simul_remesas_expor_original
end type
type st_anyoret from statictext within w_int_simul_remesas_expor_original
end type
type em_anyoret from u_em_campo within w_int_simul_remesas_expor_original
end type
type uo_tipo2 from u_marca_lista within w_int_simul_remesas_expor_original
end type
type cb_1 from commandbutton within w_int_simul_remesas_expor_original
end type
type uo_tipodoc from u_marca_lista within w_int_simul_remesas_expor_original
end type
type dw_efectos_marcados from datawindow within w_int_simul_remesas_expor_original
end type
end forward

global type w_int_simul_remesas_expor_original from w_int_con_empresa
integer x = 18
integer y = 308
integer width = 2898
integer height = 1968
pb_1 pb_1
dw_listado dw_listado
st_remesa st_remesa
em_remesa em_remesa
em_fecharemesa em_fecharemesa
cb_continuar cb_continuar
pb_imp_recibos pb_imp_recibos
gb_2 gb_2
gb_1 gb_1
em_vto_desde em_vto_desde
cb_marcar cb_marcar
cb_desmarca cb_desmarca
dw_remesas dw_remesas
dw_recibos dw_recibos
st_2 st_2
em_vto_hasta em_vto_hasta
st_6 st_6
st_7 st_7
st_9 st_9
st_11 st_11
cb_retrocede cb_retrocede
st_banco st_banco
uo_banco uo_banco
cb_salir cb_salir
cb_ejecuta cb_ejecuta
cb_bancos cb_bancos
dw_bancos dw_bancos
dw_lgasban dw_lgasban
uo_bancorem uo_bancorem
st_3 st_3
dw_gastos dw_gastos
dw_detalle dw_detalle
st_imp_recibos st_imp_recibos
st_anyoret st_anyoret
em_anyoret em_anyoret
uo_tipo2 uo_tipo2
cb_1 cb_1
uo_tipodoc uo_tipodoc
dw_efectos_marcados dw_efectos_marcados
end type
global w_int_simul_remesas_expor_original w_int_simul_remesas_expor_original

type variables
string filtro,modi
decimal var_max
String tipo_total,tipo_remesa
Boolean retroceder = FALSE
Dec{0} var_rem

str_paramemp em
end variables

forward prototypes
public subroutine f_control ()
public subroutine f_marca_todo ()
public subroutine f_control_retroceso ()
public subroutine f_desactivo_retroceder ()
public function decimal calculo_intereses (string banco, string tipodoc, decimal nominal, datetime vto, datetime fecrem)
public function decimal calculo_timbres (string codigo, decimal nominal)
public subroutine f_creo_remesa ()
public subroutine f_retroceder_remesa (string empresa, string banco, decimal anyo, decimal remesa)
public subroutine f_refrescar ()
end prototypes

public subroutine f_control ();Dec 		registros
Datetime fecha1
String	situ

dw_detalle.Reset()

dw_detalle.SetTransObject(sqlca)

situ = '0'
// Recogemos los tipos de documento
string tipodoc[]
string tipo,marca
long   i
for i = 1 to uo_tipodoc.dw_marca.rowcount()
	marca = 	uo_tipodoc.dw_marca.getitemstring(i,"marca")
	if marca = "S" then
		tipo = uo_tipodoc.dw_marca.getitemstring(i,"codigo")		
		tipodoc[upperbound(tipodoc) + 1] = tipo		
	end if		
next

dw_detalle.Retrieve(codigo_empresa,tipodoc,Datetime(Date(em_vto_desde.text)),DateTime(Date(em_vto_hasta.text)),situ)

registros = dw_detalle.RowCount()
If registros = 0 Then Return

dw_detalle.visible=true
em_vto_desde.enabled=false
em_vto_hasta.enabled=false
cb_1.enabled=false
cb_continuar.enabled=false
cb_retrocede.enabled = FALSE
dw_detalle.enabled=true
cb_salir.enabled=true
cb_marcar.enabled   = True
cb_desmarca.enabled = True
cb_ejecuta.visible = FALSE
cb_bancos.enabled = TRUE

dw_detalle.setfocus()
end subroutine

public subroutine f_marca_todo ();Integer lineas,j
string controles
long anyo,orden,posicion
dec{0} var_importe,var_total,var_dif

IF dw_detalle.Rowcount()=0 THEN RETURN

lineas = dw_detalle.Rowcount()

FOR j = 1 TO lineas
   controles =  dw_detalle.GetItemString(j,"libre")
   IF controles = "S" THEN
	ELSE
		dw_detalle.SetItem(j,"libre","S")
		anyo      =  dw_detalle.object.anyo[j]
		orden     =  dw_detalle.object.orden[j]
		posicion  = dw_efectos_marcados.find("anyo = "+string(anyo)+"and orden = "+string(orden),1,dw_efectos_marcados.rowcount())
		if posicion = 0 then
			posicion = dw_efectos_marcados.insertrow(0)	 
			dw_efectos_marcados.object.anyo[posicion]  = anyo
			dw_efectos_marcados.object.orden[posicion] = orden
		end if  		  
	END IF
NEXT 
end subroutine

public subroutine f_control_retroceso ();Dec 		registros
Datetime fecha1
String	situ

dw_detalle.Reset()

dw_detalle.SetTransObject(sqlca)

situ = '1'
// Recogemos los tipos de documento
string tipodoc[]
string tipo,marca
integer i

for i = 1 to uo_tipodoc.dw_marca.rowcount()
	marca = 	uo_tipodoc.dw_marca.getitemstring(i,"marca")
	if marca = "S" then
		tipo = uo_tipodoc.dw_marca.getitemstring(i,"codigo")		
		tipodoc[upperbound(tipodoc) + 1] = tipo		
	end if		
next

dw_detalle.Retrieve(codigo_empresa,tipodoc,Datetime(Date(em_vto_desde.text)),DateTime(Date(em_vto_hasta.text)),situ)

registros = dw_detalle.RowCount()
If registros = 0 Then Return

dw_detalle.visible   = true
em_vto_desde.enabled = false
em_vto_hasta.enabled = false
cb_1.enabled         = false
cb_continuar.enabled = TRUE
dw_detalle.enabled   = true
cb_salir.enabled     = true
cb_marcar.enabled    = True
cb_desmarca.enabled  = True

dw_detalle.setfocus()
end subroutine

public subroutine f_desactivo_retroceder ();
st_banco.visible 	 		= FALSE
st_anyoret.visible  		= FALSE
st_remesa.visible  		= FALSE
em_remesa.visible  		= FALSE
uo_banco.visible 	 		= FALSE
em_anyoret.visible		= FALSE
uo_banco.em_codigo.text	= ""
uo_banco.em_campo.text	= ""
em_anyoret.text			= ""
em_remesa.text				= ""

retroceder 					= FALSE
dw_detalle.visible		= FALSE
em_vto_desde.enabled		= TRUE
em_vto_hasta.enabled		= TRUE
cb_1.enabled            = true
cb_continuar.enabled		= TRUE
em_fecharemesa.enabled	= TRUE
cb_salir.enabled			= TRUE
dw_detalle.enabled		= FALSE
cb_marcar.enabled   		= FALSE
cb_desmarca.enabled 		= FALSE
cb_ejecuta.enabled		= FALSE
cb_ejecuta.visible		= FALSE
uo_tipo2.visible			= FALSE
cb_bancos.enabled			= FALSE
dw_gastos.visible			= FALSE
st_3.visible				= FALSE
uo_bancorem.visible		= FALSE
st_imp_recibos.enabled	= FALSE
pb_imp_recibos.enabled	= FALSE
st_imp_recibos.visible	= FALSE
pb_imp_recibos.visible	= FALSE

uo_bancorem.em_codigo.text = ""
uo_bancorem.em_campo.text  = ""
em_vto_hasta.text				= ""

f_activar_campo(em_vto_desde)
end subroutine

public function decimal calculo_intereses (string banco, string tipodoc, decimal nominal, datetime vto, datetime fecrem);Integer	dias,diasanyo
Dec		int30,int60,int90,int120,int150,int180,intmas,intmin,porinter
Date		vencim,frem
Dec{0}	impinteres

SELECT carbangas.interes30,carbangas.interes60,carbangas.interes90,
		 carbangas.interes120,carbangas.interes150,carbangas.interes180,
		 carbangas.interesmas,carbangas.interesminim,carbangas.dias_anyo
	INTO :int30,:int60,:int90,:int120,:int150,:int180,:intmas,:intmin,
		  :diasanyo FROM carbangas
WHERE carbangas.empresa = :codigo_empresa
AND   carbangas.banco	= :banco
AND   carbangas.tipodoc	= :tipodoc
AND   carbangas.naciextra = "E" USING SQLCA;

IF SQLCA.SQLCode <> 0 THEN
	int30  = 0
	int60  = 0
	int90  = 0
	int120 = 0
	int150 = 0
	int180 = 0
	intmas = 0
	RETURN 0
END IF

vencim = Date(vto)
frem	 = Date(fecrem)

dias = DaysAfter(frem,vencim)

IF dias < 1 THEN
	RETURN 0
END IF

CHOOSE CASE dias
	CASE is < 30 
		porinter = int30
	CASE 30 TO 59
		porinter = int60
	CASE 60 TO 89
		porinter = int90	
	CASE 90 TO 119
		porinter = int120
	CASE 120 TO 149
		porinter = int150
	CASE 150 TO 179
		porinter = int180
	CASE ELSE
		porinter = intmas
END CHOOSE

IF porinter = 0 OR IsNull(porinter) THEN RETURN 0

impinteres = porinter * nominal / 100
impinteres = (impinteres / diasanyo) * dias

IF Not IsNull(intmin) AND intmin > 0 THEN
	IF intmin > impinteres THEN impinteres = intmin
END IF

RETURN impinteres
end function

public function decimal calculo_timbres (string codigo, decimal nominal);Dec{0}	top1,top2,top3,top4,top5,top6,top7,top8,top9,top10,top11,top12,top13,top14,top15
Dec{0}	tim1,tim2,tim3,tim4,tim5,tim6,tim7,tim8,tim9,tim10,tim11,tim12,tim13,tim14,tim15
Dec{0}	imptim

SELECT cartimbres.tope1,cartimbres.tope2,cartimbres.tope3,
		 cartimbres.tope4,cartimbres.tope5,cartimbres.tope6,
		 cartimbres.tope7,cartimbres.tope8,cartimbres.tope9,
		 cartimbres.tope10,cartimbres.tope11,cartimbres.tope12,
		 cartimbres.tope13,cartimbres.tope14,cartimbres.tope15,
		 cartimbres.timbre1,cartimbres.timbre2,cartimbres.timbre3,
		 cartimbres.timbre4,cartimbres.timbre5,cartimbres.timbre6,
		 cartimbres.timbre7,cartimbres.timbre8,cartimbres.timbre9,
		 cartimbres.timbre10,cartimbres.timbre11,cartimbres.timbre12,
		 cartimbres.timbre13,cartimbres.timbre14,cartimbres.timbre15
	INTO :top1,:top2,:top3,:top4,:top5,:top6,:top7,:top8,:top9,:top10,
		  :top11,:top12,:top13,:top14,:top15,
		  :tim1,:tim2,:tim3,:tim4,:tim5,:tim6,:tim7,:tim8,:tim9,:tim10,
		  :tim11,:tim12,:tim13,:tim14,:tim15	FROM cartimbres
WHERE cartimbres.codigo = :codigo USING SQLCA;

IF SQLCA.SQLCode <> 0 THEN
	RETURN 0
END IF

CHOOSE CASE nominal
	CASE is <= top1 
		imptim = tim1
	CASE top1+1 TO top2
		imptim = tim2
	CASE top2+1 TO top3
		imptim = tim3	
	CASE top3+1 TO top4
		imptim = tim4
	CASE top4+1 TO top5
		imptim = tim5
	CASE top5+1 TO top6
		imptim = tim6
	CASE top6+1 TO top7
		imptim = tim7
	CASE top7+1 TO top8
		imptim = tim8
	CASE top8+1 TO top9
		imptim = tim9
	CASE top9+1 TO top10
		imptim = tim10
	CASE top10+1 TO top11
		imptim = tim11
	CASE top11+1 TO top12
		imptim = tim12
	CASE top12+1 TO top13
		imptim = tim13
	CASE top13+1 TO top14
		imptim = tim14
	CASE IS > top14+1 
		imptim = tim15
	CASE ELSE
		imptim = 0
END CHOOSE

IF IsNull(imptim) THEN imptim = 0

RETURN imptim
end function

public subroutine f_creo_remesa ();Integer 	lineas,j
String 	controles,codpar
Dec{0}	var_anyo,var_orden,var_anyorem
DateTime	fecrem
Boolean	bien
str_carremesas cab


IF dw_detalle.Rowcount()=0 THEN RETURN

lineas = dw_detalle.Rowcount()

bien = TRUE

fecrem		= DateTime(Date(em_fecharemesa.text))
var_anyorem = Year(Date(fecrem))
codpar		= "E"+Trim(uo_bancorem.em_codigo.text)
var_rem     = f_numero_contador(codigo_empresa,String(var_anyorem),codpar)
IF var_rem = 0 THEN
	bien = FALSE
	MessageBox("CONTADOR DE REMESAS","Error en contador de remesa "+codpar)
	ROLLBACK;
	f_desactivo_retroceder()
END IF

FOR j = 1 TO lineas
   controles =  dw_detalle.GetItemString(j,"libre")
   IF controles = "S" THEN
		var_anyo	= dw_detalle.GetItemNumber(j,"anyo")
		var_orden= dw_detalle.GetItemNumber(j,"orden")
		
		UPDATE carefectos	SET carefectos.banco = :uo_bancorem.em_codigo.text,
		 							 carefectos.remesa= :var_rem,
		 							 carefectos.fremesa=:fecrem,
		 							 carefectos.anyo_remesa=:var_anyorem,
									 carefectos.situacion = '6',
									 carefectos.tipo_remesa = '2'
	 	WHERE carefectos.empresa = :codigo_empresa
		AND   carefectos.anyo    = :var_anyo
		AND   carefectos.orden   = :var_orden USING SQLCA;
		  
	END IF
NEXT 

// Creacion de la cabecera de remesa
cab.empresa		= codigo_empresa
cab.anyo			= var_anyorem
cab.banco		= uo_bancorem.em_codigo.text
cab.remesa		= var_rem
cab.naci_extra	= "E"
cab.fremesa		= DateTime(date(em_fecharemesa.text))

// Se pone como tipo de remesa el que figura en parametros de empresa
//cab.tipodoc		= uo_tipo.em_codigo.text
cab.tipodoc		= em.tipodoc_rem

cab.situacion 	= "2"
cab.moneda		= f_moneda_empresa(codigo_empresa)
cab.importe		= 0
cab.divisas		= 0
cab.totgastos	= 0
cab.tiporem		= '2'

bien = f_insert_carremesas(cab)

IF bien THEN
	COMMIT;
	dw_efectos_marcados.reset()
ELSE
	ROLLBACK;
END IF

String cabecera
cabecera= inputbox("Impresion Remesa","Desea Imprimir cabecera:","N","")
dw_listado.Retrieve(codigo_empresa,var_anyorem,uo_bancorem.em_codigo.text,var_rem,cabecera)
f_imprimir_datawindow(dw_listado)


end subroutine

public subroutine f_retroceder_remesa (string empresa, string banco, decimal anyo, decimal remesa);
UPDATE carefectos	SET carefectos.banco = "",
 							 carefectos.remesa= null,
 							 carefectos.fremesa="",
 							 carefectos.anyo_remesa= null,
							 carefectos.situacion = "0"
WHERE carefectos.empresa 	  = :codigo_empresa
AND   carefectos.banco   	  = :banco
AND   carefectos.anyo_remesa = :anyo
AND 	carefectos.remesa		  = :remesa
AND   carefectos.Nacional	  = "N" USING SQLCA;
if sqlca.sqlcode = 0 then
	UPDATE carremesas SET carremesas.situacion = '9'
	WHERE carremesas.empresa	= :codigo_empresa
	AND   carremesas.anyo		= :anyo
	AND   carremesas.banco		= :banco
	AND   carremesas.remesa		= :remesa
	AND   carremesas.naci_extra = 'E' USING SQLCA;
	if sqlca.sqlcode = 0 then
		commit;
	else
		rollback;
		messagebox("Error",sqlca.sqlerrtext)
	end if
else
	rollback;
	messagebox("Error",sqlca.sqlerrtext)
end if
end subroutine

public subroutine f_refrescar ();long indice,total,anyo,orden,posicion

f_control()
total = dw_efectos_marcados.rowcount()
for indice = 1 to total
	anyo      = dw_efectos_marcados.object.anyo[indice]
	orden     = dw_efectos_marcados.object.orden[indice]	
	posicion  = dw_detalle.find("anyo = "+string(anyo)+"and orden = "+string(orden),1,dw_detalle.rowcount())
	if posicion > 0 then
		dw_detalle.object.libre[posicion] = "S"
	else
		dw_efectos_marcados.deleterow(indice)	 		
	end if
next


end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Simulación de Remesas de Exportación"
This.title=istr_parametros.s_titulo_ventana

dw_listado.SetTransObject(SQLCA)
// dw con todos los efectos que cumplen las condiciones.
dw_detalle.SetTransObject(SQLCA)
dw_recibos.SetTransObject(SQLCA)
// dw con los gastos por banco. Una linea para cada gasto. se le envia
// el banco
dw_lgasban.SetTransObject(SQLCA)
// dw con el calculo hecho para cada uno de los efectos marcados.
// agrupado por bancos.
dw_gastos.SetTransObject(SQLCA)
dw_efectos_marcados.settransobject(sqlca)
dw_detalle.visible = FALSE

em_vto_desde.text = string(relativedate(today(),-365))
em_fecharemesa.text = String(Today())

// Rellenamos la datawindow de marcado de bancos
Integer x2,registros2 
String var_codigo2,var_texto2,marca2

dw_bancos.SetTransObject(SQLCA)
registros2=dw_bancos.Retrieve(codigo_empresa)
IF registros2<>0 THEN
	FOR x2= 1 To registros2
		var_codigo2  = dw_bancos.GetItemString(x2,"banco")
		var_texto2   = dw_bancos.GetItemString(x2,"nombre")
		marca2="S"
		uo_tipo2.dw_marca.InsertRow(x2)
		uo_tipo2.dw_marca.setitem(x2,"marca",marca2)
		uo_tipo2.dw_marca.setitem(x2,"codigo",var_codigo2)
		uo_tipo2.dw_marca.setitem(x2,"texto",var_texto2)
	NEXT
END IF
uo_tipo2.st_titulo1.text="Banco"
uo_tipo2.st_titulo2.text="Nombre"

// Los tipos de documento

Integer x3,registros3 
String var_codigo3,var_texto3,marca3
DataStore dw_comodin
//dw_comodin = f_cargar_cursor("Select tipodoc,texto from cartipodoc where empresa = '"+codigo_empresa+"'")
f_cargar_cursor_nuevo("Select tipodoc,texto from cartipodoc where empresa = '"+codigo_empresa+"'", dw_comodin)
dw_comodin.setsort("number(tipodoc)")
dw_comodin.sort()
registros3=dw_comodin.RowCOunt()
If registros3<>0 THEN
 FOR x3= 1 To registros3
  var_codigo3  = dw_comodin.GetItemString(x3,"tipodoc")
  var_texto3   = dw_comodin.GetItemString(x3,"texto")
  marca3="S"
  uo_tipodoc.dw_marca.InsertRow(x3)
  uo_tipodoc.dw_marca.setitem(x3,"marca",marca3)
  uo_tipodoc.dw_marca.setitem(x3,"codigo",var_codigo3)
  uo_tipodoc.dw_marca.setitem(x3,"texto",var_texto3)
NEXT
END IF
uo_tipodoc.st_titulo1.text="Tipo Doc."
uo_tipodoc.st_titulo2.text="Descripcion"

// En la variable em los parametros de la empresa 
em = f_paramemp(codigo_Empresa)

f_activar_campo(em_vto_desde)

destroy dw_comodin
end event

on w_int_simul_remesas_expor_original.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_listado=create dw_listado
this.st_remesa=create st_remesa
this.em_remesa=create em_remesa
this.em_fecharemesa=create em_fecharemesa
this.cb_continuar=create cb_continuar
this.pb_imp_recibos=create pb_imp_recibos
this.gb_2=create gb_2
this.gb_1=create gb_1
this.em_vto_desde=create em_vto_desde
this.cb_marcar=create cb_marcar
this.cb_desmarca=create cb_desmarca
this.dw_remesas=create dw_remesas
this.dw_recibos=create dw_recibos
this.st_2=create st_2
this.em_vto_hasta=create em_vto_hasta
this.st_6=create st_6
this.st_7=create st_7
this.st_9=create st_9
this.st_11=create st_11
this.cb_retrocede=create cb_retrocede
this.st_banco=create st_banco
this.uo_banco=create uo_banco
this.cb_salir=create cb_salir
this.cb_ejecuta=create cb_ejecuta
this.cb_bancos=create cb_bancos
this.dw_bancos=create dw_bancos
this.dw_lgasban=create dw_lgasban
this.uo_bancorem=create uo_bancorem
this.st_3=create st_3
this.dw_gastos=create dw_gastos
this.dw_detalle=create dw_detalle
this.st_imp_recibos=create st_imp_recibos
this.st_anyoret=create st_anyoret
this.em_anyoret=create em_anyoret
this.uo_tipo2=create uo_tipo2
this.cb_1=create cb_1
this.uo_tipodoc=create uo_tipodoc
this.dw_efectos_marcados=create dw_efectos_marcados
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_listado
this.Control[iCurrent+3]=this.st_remesa
this.Control[iCurrent+4]=this.em_remesa
this.Control[iCurrent+5]=this.em_fecharemesa
this.Control[iCurrent+6]=this.cb_continuar
this.Control[iCurrent+7]=this.pb_imp_recibos
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.em_vto_desde
this.Control[iCurrent+11]=this.cb_marcar
this.Control[iCurrent+12]=this.cb_desmarca
this.Control[iCurrent+13]=this.dw_remesas
this.Control[iCurrent+14]=this.dw_recibos
this.Control[iCurrent+15]=this.st_2
this.Control[iCurrent+16]=this.em_vto_hasta
this.Control[iCurrent+17]=this.st_6
this.Control[iCurrent+18]=this.st_7
this.Control[iCurrent+19]=this.st_9
this.Control[iCurrent+20]=this.st_11
this.Control[iCurrent+21]=this.cb_retrocede
this.Control[iCurrent+22]=this.st_banco
this.Control[iCurrent+23]=this.uo_banco
this.Control[iCurrent+24]=this.cb_salir
this.Control[iCurrent+25]=this.cb_ejecuta
this.Control[iCurrent+26]=this.cb_bancos
this.Control[iCurrent+27]=this.dw_bancos
this.Control[iCurrent+28]=this.dw_lgasban
this.Control[iCurrent+29]=this.uo_bancorem
this.Control[iCurrent+30]=this.st_3
this.Control[iCurrent+31]=this.dw_gastos
this.Control[iCurrent+32]=this.dw_detalle
this.Control[iCurrent+33]=this.st_imp_recibos
this.Control[iCurrent+34]=this.st_anyoret
this.Control[iCurrent+35]=this.em_anyoret
this.Control[iCurrent+36]=this.uo_tipo2
this.Control[iCurrent+37]=this.cb_1
this.Control[iCurrent+38]=this.uo_tipodoc
this.Control[iCurrent+39]=this.dw_efectos_marcados
end on

on w_int_simul_remesas_expor_original.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_listado)
destroy(this.st_remesa)
destroy(this.em_remesa)
destroy(this.em_fecharemesa)
destroy(this.cb_continuar)
destroy(this.pb_imp_recibos)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.em_vto_desde)
destroy(this.cb_marcar)
destroy(this.cb_desmarca)
destroy(this.dw_remesas)
destroy(this.dw_recibos)
destroy(this.st_2)
destroy(this.em_vto_hasta)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_9)
destroy(this.st_11)
destroy(this.cb_retrocede)
destroy(this.st_banco)
destroy(this.uo_banco)
destroy(this.cb_salir)
destroy(this.cb_ejecuta)
destroy(this.cb_bancos)
destroy(this.dw_bancos)
destroy(this.dw_lgasban)
destroy(this.uo_bancorem)
destroy(this.st_3)
destroy(this.dw_gastos)
destroy(this.dw_detalle)
destroy(this.st_imp_recibos)
destroy(this.st_anyoret)
destroy(this.em_anyoret)
destroy(this.uo_tipo2)
destroy(this.cb_1)
destroy(this.uo_tipodoc)
destroy(this.dw_efectos_marcados)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_simul_remesas_expor_original
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_simul_remesas_expor_original
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_simul_remesas_expor_original
integer x = 9
integer y = 4
integer width = 2427
end type

type pb_1 from upb_salir within w_int_simul_remesas_expor_original
integer x = 2738
integer y = 4
integer width = 110
integer height = 92
integer taborder = 0
end type

type dw_listado from datawindow within w_int_simul_remesas_expor_original
boolean visible = false
integer width = 160
integer height = 252
boolean bringtotop = true
string dataobject = "report_simul_remesas_expor"
boolean livescroll = true
end type

type st_remesa from statictext within w_int_simul_remesas_expor_original
boolean visible = false
integer x = 2519
integer y = 188
integer width = 265
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\Mano.cur"
long textcolor = 16711680
long backcolor = 12632256
string text = "NºReme."
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;
IF Trim(uo_banco.em_codigo.text) = '' OR IsNull(uo_banco.em_codigo.text) THEN
	f_activar_campo(uo_banco.em_campo)
END IF

IF Trim(em_anyoret.text) = "" OR IsNull(em_anyoret.text) THEN
	f_activar_campo(em_anyoret)
END IF

dw_remesas.visible = TRUE
dw_remesas.SetTransObject(SQLCA)
IF dw_remesas.Retrieve(codigo_empresa,uo_banco.em_codigo.text,Dec(em_anyoret.text)) = 0 Then
	dw_remesas.visible = FALSE
END IF
f_activar_campo(em_remesa)
end event

type em_remesa from u_em_campo within w_int_simul_remesas_expor_original
event getfocus pbm_ensetfocus
event modificado pbm_custom02
boolean visible = false
integer x = 2519
integer y = 260
integer width = 265
integer height = 76
integer taborder = 0
long backcolor = 16777215
end type

event getfocus;call super::getfocus;if len(trim(string(uo_banco.em_codigo.text)))=0 then 
	f_activar_campo(uo_banco.em_campo)
	Return
end if

IF Len(Trim(em_anyoret.text)) = 0 THEN
	f_activar_campo(em_anyoret)
	RETURN
END IF


        
end event

event modificado;call super::modificado;Dec var_anyo,var_remesa
var_anyo=Dec(em_anyoret.text)
var_remesa=dec(em_remesa.text)
datetime var_f
string var_sit,tipo
Dec num,recibo

select Count(*)  into :num from  carefectos
where carefectos.empresa     = :codigo_empresa
and   carefectos.anyo_remesa = :var_anyo
and   carefectos.remesa      = :var_remesa
and   carefectos.banco       = :uo_banco.em_codigo.text
and   carefectos.situacion   = "1";
IF IsNUll(num) Then num = 0

CHOOSE CASE num
 	 CASE 0
		MessageBox("Retrocesión de Remesas","No hay efectos en la Remesa",Exclamation!)
      f_activar_campo(em_remesa)
   CASE ELSE
		retroceder = TRUE
END CHOOSE


end event

event losefocus;call super::losefocus;dw_remesas.visible = FALSE

end event

type em_fecharemesa from u_em_campo within w_int_simul_remesas_expor_original
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 613
integer y = 424
integer width = 453
integer taborder = 30
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

event getfocus;call super::getfocus;//IF len(trim(string(em_remesa.text))) = 0 THEN f_activar_campo(em_remesa)




        
end event

type cb_continuar from commandbutton within w_int_simul_remesas_expor_original
integer x = 1129
integer y = 424
integer width = 302
integer height = 68
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Continuar"
end type

event clicked;
IF em_vto_desde.text = '00-00-00' THEN
	f_activar_campo(em_vto_desde)
END IF

IF em_vto_hasta.text = '00-00-00' THEN
	f_activar_campo(em_vto_hasta)
END IF

if em_fecharemesa.text="00-00-00" then
	f_activar_campo(em_fecharemesa)
	return
end if

uo_tipodoc.visible = false
if dw_efectos_marcados.rowcount() = 0 then
	f_control()
else
	f_refrescar()
end if


end event

type pb_imp_recibos from upb_imprimir within w_int_simul_remesas_expor_original
event clicked pbm_bnclicked
boolean visible = false
integer x = 2752
integer y = 1268
integer height = 100
integer taborder = 0
boolean originalsize = false
string picturename = "print!"
string disabledname = "c:\bmp\imp32_no.bmp"
end type

event clicked;DateTime	fecrem
Dec{0}	var_anyorem

fecrem		= DateTime(Date(em_fecharemesa.text))
var_anyorem = Year(Date(fecrem))

dw_recibos.SetTransObject(SQLCA)

dw_recibos.DataObject = "report_lcr"

dw_recibos.SetTransObject(SQLCA)
dw_recibos.Retrieve(codigo_empresa,var_anyorem,uo_bancorem.em_codigo.text,var_rem)
f_imprimir_datawindow(dw_recibos)

UPDATE carremesas SET carremesas.situacion = '2'
WHERE carremesas.empresa	= :codigo_empresa
AND   carremesas.anyo		= :var_anyorem
AND   carremesas.banco		= :uo_bancorem.em_codigo.text
AND   carremesas.remesa		= :var_rem
AND   carremesas.naci_extra = 'E' USING SQLCA;

f_desactivo_retroceder()
end event

type gb_2 from groupbox within w_int_simul_remesas_expor_original
integer x = 1111
integer y = 92
integer width = 366
integer height = 136
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_1 from groupbox within w_int_simul_remesas_expor_original
integer x = 1115
integer y = 384
integer width = 334
integer height = 120
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
end type

type em_vto_desde from editmask within w_int_simul_remesas_expor_original
event losefocus pbm_enkillfocus
event modified pbm_enmodified
integer x = 27
integer y = 268
integer width = 288
integer height = 76
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

event losefocus;
IF trim(em_vto_desde.text) = "00-00-00"  THEN
	em_vto_desde.text = '01-01-95'
END IF
end event

event getfocus;f_desactivo_retroceder()
cb_retrocede.enabled = TRUE
end event

type cb_marcar from u_cancelar within w_int_simul_remesas_expor_original
event clicked pbm_bnclicked
integer x = 338
integer y = 1700
integer width = 325
integer height = 72
integer taborder = 0
boolean bringtotop = true
boolean enabled = false
string text = "Marca"
end type

event clicked;f_marca_todo()
end event

type cb_desmarca from u_cancelar within w_int_simul_remesas_expor_original
event clicked pbm_bnclicked
integer x = 663
integer y = 1700
integer width = 338
integer height = 72
integer taborder = 0
boolean bringtotop = true
boolean enabled = false
string text = "Desmarcar"
end type

event clicked;integer lineas,Xx
string controles


dw_efectos_marcados.reset()
IF dw_detalle.Rowcount()=0 THEN RETURN

lineas = dw_detalle.Rowcount()

FOR Xx = 1 TO lineas
  controles =  dw_detalle.GetItemString(Xx,"libre")
  IF controles = "S" THEN
		dw_detalle.SetItem(Xx,"libre","N")
	END IF
NEXT
end event

type dw_remesas from datawindow within w_int_simul_remesas_expor_original
boolean visible = false
integer x = 1742
integer y = 340
integer width = 987
integer height = 652
string dataobject = "dw_con_simul_remesas2_expor"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;em_remesa.text = String(dw_remesas.GetItemNumber(row,"remesa"),"######")
em_fecharemesa.text = String(Date(dw_remesas.GetItemDateTime(dw_remesas.GetRow(),"fremesa")),"dd-mm-yy")
dw_remesas.visible = FALSE
dw_remesas.reset()
f_activar_campo(em_remesa)
end event

type dw_recibos from datawindow within w_int_simul_remesas_expor_original
boolean visible = false
integer x = 2437
integer y = 4
integer width = 302
integer height = 100
boolean bringtotop = true
boolean livescroll = true
end type

type st_2 from statictext within w_int_simul_remesas_expor_original
integer x = 27
integer y = 108
integer width = 581
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Vencimiento"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_vto_hasta from editmask within w_int_simul_remesas_expor_original
event losefocus pbm_enkillfocus
event modified pbm_enmodified
integer x = 315
integer y = 268
integer width = 288
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

event losefocus;IF Trim(em_vto_hasta.text) = '00-00-00' OR IsNull(em_vto_desde.text) THEN
	em_vto_hasta.text = '31-12-15'
END IF

end event

event modified;IF DateTime(Date(em_vto_desde.text)) > DateTime(Date(em_vto_hasta.text)) THEN
	MessageBox("Error en fechas","Fecha DESDE Mayor que fecha HASTA",Exclamation!)
	f_activar_campo(em_vto_desde)
END IF

end event

type st_6 from statictext within w_int_simul_remesas_expor_original
integer x = 27
integer y = 188
integer width = 293
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Desde"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_7 from statictext within w_int_simul_remesas_expor_original
integer x = 320
integer y = 188
integer width = 288
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Hasta"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_9 from statictext within w_int_simul_remesas_expor_original
integer x = 27
integer y = 352
integer width = 585
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Tipo Efec. a Remesar"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_11 from statictext within w_int_simul_remesas_expor_original
integer x = 608
integer y = 352
integer width = 457
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Fecha Remesa"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_retrocede from commandbutton within w_int_simul_remesas_expor_original
event clicked pbm_bnclicked
integer x = 1125
integer y = 128
integer width = 338
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Retroceder "
end type

event clicked;
IF Not retroceder THEN
	st_banco.visible 	 = TRUE
	st_remesa.visible  = TRUE
	st_anyoret.visible = TRUE
	em_anyoret.visible = TRUE
	em_remesa.visible  = TRUE
	uo_banco.visible 	 = TRUE
	em_vto_desde.enabled		= FALSE
	em_vto_hasta.enabled		= FALSE
	cb_1.enabled		      = FALSE
	cb_continuar.enabled		= FALSE
	em_fecharemesa.enabled	= FALSE
	f_activar_campo(uo_banco.em_campo)
ELSE
	f_retroceder_remesa(codigo_empresa,uo_banco.em_codigo.text,Dec(em_anyoret.text),Dec(em_remesa.text))
	retroceder 			 = FALSE
	st_banco.visible 	 = FALSE
	st_remesa.visible  = FALSE
	st_anyoret.visible = FALSE
	em_anyoret.visible = FALSE
	em_remesa.visible  = FALSE
	uo_banco.visible 	 = FALSE
	f_desactivo_retroceder()
END IF
end event

type st_banco from statictext within w_int_simul_remesas_expor_original
event clicked pbm_bnclicked
boolean visible = false
integer x = 1481
integer y = 188
integer width = 773
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\Mano.cur"
long backcolor = 12632256
string text = "Banco"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;//f_activar_campo(em_banco)
//dw_remesas.visible = TRUE
//dw_remesas.SetTransObject(SQLCA)
//IF dw_remesas.retrieve(codigo_empresa,em_banco.text) = 0 Then
//	dw_remesas.visible = FALSE
//END IF
//f_activar_campo(em_remesa)
end event

type uo_banco from u_em_campo_2 within w_int_simul_remesas_expor_original
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
boolean visible = false
integer x = 1481
integer y = 260
integer width = 773
integer height = 76
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_banco.em_campo.text=f_nombre_banco(codigo_empresa,uo_banco.em_codigo.text)
If Trim(uo_banco.em_campo.text)="" then
	uo_banco.em_campo.text=""
	uo_banco.em_codigo.text=""
	Return
end if 

f_activar_campo(em_anyoret)


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Bancos"
ue_datawindow ="dw_ayuda_carbancos"
valor_empresa = TRUE

end event

on uo_banco.destroy
call u_em_campo_2::destroy
end on

type cb_salir from commandbutton within w_int_simul_remesas_expor_original
integer x = 14
integer y = 1700
integer width = 325
integer height = 72
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Salir"
end type

event clicked;f_desactivo_retroceder()
RETURN
end event

type cb_ejecuta from commandbutton within w_int_simul_remesas_expor_original
event clicked pbm_bnclicked
integer x = 1705
integer y = 1704
integer width = 325
integer height = 72
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Confirmar"
end type

event clicked;Integer	efectos,bancos,gastos,lin
Long		x1,x2,x3
String 	banc,codgas,cliefec
Dec{0}	anyoefec,orden,impefec,interefec,impgas,impmin
DateTime	vtoefec
Dec{2}	porgas

bancos = uo_tipo2.dw_marca.RowCount()
IF bancos =0 THEN 
	Messagebox("Selección de Bancos","Debe seleccionar al menos uno",Exclamation!)
	RETURN
END IF

efectos = dw_detalle.RowCount()
dw_gastos.Reset()

uo_tipo2.visible = FALSE
// Calculo gastos para los bancos que hay marcados
FOR x1 = 1 TO bancos
	IF uo_tipo2.dw_marca.GetItemString(x1,"marca") = "S" THEN
		banc = uo_tipo2.dw_marca.GetItemString(x1,"codigo")
		dw_lgasban.Reset()
		// Tengo en la dw los gastos del banco. Una linea por cada gasto
		gastos = dw_lgasban.Retrieve(codigo_empresa,banc,em.tipodoc_rem,"E")
		// Bucle para cada uno de los efectos marcados
		FOR x2 = 1 TO efectos
			IF dw_detalle.GetItemString(x2,"libre") = "S" THEN
      		anyoefec = dw_detalle.GetItemNumber(x2,"anyo")
				orden    = dw_detalle.GetItemNumber(x2,"orden")
				cliefec  = dw_detalle.GetItemString(x2,"carefectos_cliente")
				vtoefec  = dw_detalle.GetItemDateTime(x2,"fvto")
				impefec  = dw_detalle.GetItemNumber(x2,"importe")
				lin = dw_gastos.InsertRow(0)
//				lin = dw_gastos.RowCount()
				dw_gastos.SetItem(lin,"empresa",codigo_empresa)
				dw_gastos.SetItem(lin,"banco",banc)
				dw_gastos.SetItem(lin,"anyo",anyoefec)
				dw_gastos.SetItem(lin,"orden",orden)
				dw_gastos.SetItem(lin,"cliente",cliefec)
				dw_gastos.SetItem(lin,"vto",vtoefec)
				dw_gastos.SetItem(lin,"importe",impefec)
				// Bucle para leer los gastos del banco
				IF gastos = 0 THEN	// No hay gastos bancarios
					dw_gastos.SetItem(lin,"codgas1",'')
					dw_gastos.SetItem(lin,"porgas1",0)
					dw_gastos.SetItem(lin,"impgas1",0)
					dw_gastos.SetItem(lin,"codgas2",'')
					dw_gastos.SetItem(lin,"porgas2",0)
					dw_gastos.SetItem(lin,"impgas2",0)
					dw_gastos.SetItem(lin,"codgas3",'')
					dw_gastos.SetItem(lin,"porgas3",0)
					dw_gastos.SetItem(lin,"impgas3",0)
					dw_gastos.SetItem(lin,"codgas4",'')
					dw_gastos.SetItem(lin,"porgas4",0)
					dw_gastos.SetItem(lin,"impgas4",0)
				ELSE
					FOR x3 = 1 TO gastos
						IF x3 > 4 THEN EXIT  // Tope de gastos
						IF x3 = 1 THEN
							interefec = Calculo_Intereses(banc,em.tipodoc_rem,impefec,vtoefec,DateTime(Date(em_fecharemesa.text)))
							dw_gastos.SetItem(lin,"intereses",interefec)
						END IF
						codgas = dw_lgasban.GetItemString(x3,"gasto")
						IF codgas > '89' THEN EXIT // Gastos Impagados
						porgas = dw_lgasban.GetItemNumber(x3,"porcentaje")
						impmin = dw_lgasban.GetItemNumber(x3,"importe")
						IF codgas = '12' THEN 		// Timbres
							impgas = Calculo_timbres(String(impmin),impefec)					
							porgas = 0
						ELSE
							IF porgas <> 0 THEN
								impgas = impefec * porgas / 100
								IF impgas < impmin THEN impgas = impmin
							ELSE
								impgas = impmin
							END IF
						END IF
						CHOOSE CASE x3
							CASE 1
								dw_gastos.SetItem(lin,"codgas1",codgas)
								dw_gastos.SetItem(lin,"porgas1",porgas)
								dw_gastos.SetItem(lin,"impgas1",impgas)
							CASE 2
								dw_gastos.SetItem(lin,"codgas2",codgas)
								dw_gastos.SetItem(lin,"porgas2",porgas)
								dw_gastos.SetItem(lin,"impgas2",impgas)
							CASE 3
								dw_gastos.SetItem(lin,"codgas3",codgas)
								dw_gastos.SetItem(lin,"porgas3",porgas)
								dw_gastos.SetItem(lin,"impgas3",impgas)
							CASE 4
								dw_gastos.SetItem(lin,"codgas4",codgas)
								dw_gastos.SetItem(lin,"porgas4",porgas)
								dw_gastos.SetItem(lin,"impgas4",impgas)
						END CHOOSE
					NEXT
				END IF
			END IF
		NEXT
	END IF
NEXT

dw_gastos.visible   = TRUE
st_3.visible		  = TRUE
uo_bancorem.visible = TRUE
f_activar_campo(uo_bancorem.em_campo)
end event

type cb_bancos from commandbutton within w_int_simul_remesas_expor_original
event clicked pbm_bnclicked
integer x = 1349
integer y = 1704
integer width = 325
integer height = 72
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Bancos"
end type

event clicked;uo_tipo2.visible 		= TRUE
em_fecharemesa.enabled	= FALSE
cb_ejecuta.visible 	= TRUE
cb_ejecuta.enabled 	= TRUE
cb_marcar.enabled  	= FALSE
cb_desmarca.enabled 	= FALSE
st_3.visible			= FALSE
uo_bancorem.visible	= FALSE
dw_gastos.Reset()
end event

type dw_bancos from datawindow within w_int_simul_remesas_expor_original
boolean visible = false
integer x = 1710
integer y = 108
integer width = 416
integer height = 72
boolean bringtotop = true
string dataobject = "dw_simul_remesas_bancos"
boolean livescroll = true
end type

type dw_lgasban from datawindow within w_int_simul_remesas_expor_original
boolean visible = false
integer x = 1682
integer y = 1376
integer width = 256
integer height = 360
boolean bringtotop = true
string dataobject = "dw_con_simul_remesas_lgasban"
boolean livescroll = true
end type

type uo_bancorem from u_em_campo_2 within w_int_simul_remesas_expor_original
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
boolean visible = false
integer x = 2263
integer y = 1372
integer width = 594
integer height = 76
integer taborder = 100
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_bancorem.em_campo.text=f_nombre_banco(codigo_empresa,uo_bancorem.em_codigo.text)
If Trim(uo_bancorem.em_campo.text)="" then
	uo_bancorem.em_campo.text=""
	uo_bancorem.em_codigo.text=""
	Return
end if
// Si son : Giros, lcr, riva o direct debiting se imprime recibo
//IF uo_tipo.em_codigo.text = '3' OR uo_tipo.em_codigo.text = '10' OR &
//   uo_tipo.em_codigo.text = '11' OR uo_tipo.em_codigo.text = '12' THEN
	st_imp_recibos.enabled	= TRUE
	pb_imp_recibos.enabled	= TRUE
	st_imp_recibos.visible	= TRUE
	pb_imp_recibos.visible	= TRUE
//ELSE
//	st_imp_recibos.enabled	= FALSE
//	pb_imp_recibos.enabled	= FALSE
//	st_imp_recibos.visible	= FALSE
//	pb_imp_recibos.visible	= FALSE
//END IF

f_creo_remesa()







end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Bancos"
ue_datawindow ="dw_ayuda_carbancos"
valor_empresa = TRUE

end event

on uo_bancorem.destroy
call u_em_campo_2::destroy
end on

type st_3 from statictext within w_int_simul_remesas_expor_original
boolean visible = false
integer x = 2043
integer y = 1372
integer width = 201
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Banco"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_gastos from datawindow within w_int_simul_remesas_expor_original
boolean visible = false
integer x = 32
integer y = 528
integer width = 2715
integer height = 836
string dataobject = "dw_con_simul_remesas_gastosban"
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_detalle from datawindow within w_int_simul_remesas_expor_original
integer x = 14
integer y = 516
integer width = 2734
integer height = 1164
string dataobject = "dw_con_simul_remesas_expor"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;Integer linea
String controles
long anyo,orden,posicion

IF f_objeto_datawindow(This) = "e_vto" Then
	SetSort("")
	SetSort("fvto")
	Sort()
	Return
END IF
IF f_objeto_datawindow(This) = "e_importe" Then
	SetSort("")
	SetSort("importe")
	Sort()
	Return
END IF

IF f_objeto_datawindow(This) = "e_cliente" Then
	SetSort("")
	SetSort("genter_razon")
	Sort()
	Return
END IF

IF f_objeto_datawindow(This) = "e_divisas" Then
	SetSort("")
	SetSort("monedas,divisas")
	Sort()
	Return
END IF

IF f_objeto_datawindow(This) = "refrescar" Then	
	f_refrescar()
END IF

if row=0 then return


linea = row
IF linea = 0 Then Return

controles =  This.GetItemString(linea,"libre")
anyo      =  this.object.anyo[linea]
orden     =  this.object.orden[linea]

IF controles = "S" THEN
  This.SetItem(linea,"libre","N")

  posicion = dw_efectos_marcados.find("anyo = "+string(anyo)+"and orden = "+string(orden),1,dw_efectos_marcados.rowcount())
  if posicion > 0 then
		dw_efectos_marcados.deleterow(posicion)	 
  end if
  
 ELSE
  This.SetItem(linea,"libre","S")
  posicion = dw_efectos_marcados.find("anyo = "+string(anyo)+"and orden = "+string(orden),1,dw_efectos_marcados.rowcount())
  if posicion = 0 then
		posicion = dw_efectos_marcados.insertrow(0)	 
		dw_efectos_marcados.object.anyo[posicion]  = anyo
		dw_efectos_marcados.object.orden[posicion] = orden
  end if    
 End If


end event

event rbuttondown;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"orden"))
  OpenWithParm(wi_mant_carefectos,lstr_param) 
End If
end event

event retrieveend;
f_marca_todo()


dw_detalle.setredraw(false)
string factura
long i
FOR i=1 TO dw_detalle.rowcount()
	factura = dw_detalle.object.factura[i]
	dw_detalle.object.carefectos_factura_n[i] = dec(factura) 
		
NEXT
dw_detalle.sort()
dw_detalle.setredraw(true)




end event

type st_imp_recibos from statictext within w_int_simul_remesas_expor_original
boolean visible = false
integer x = 2747
integer y = 1200
integer width = 114
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16776960
long backcolor = 12632256
boolean enabled = false
string text = "Rec"
alignment alignment = center!
boolean border = true
long bordercolor = 8388736
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_anyoret from statictext within w_int_simul_remesas_expor_original
event clicked pbm_bnclicked
boolean visible = false
integer x = 2254
integer y = 188
integer width = 265
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\Mano.cur"
long backcolor = 12632256
string text = "Año Rem."
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;//f_activar_campo(em_banco)
//dw_remesas.visible = TRUE
//dw_remesas.SetTransObject(SQLCA)
//IF dw_remesas.retrieve(codigo_empresa,em_banco.text) = 0 Then
//	dw_remesas.visible = FALSE
//END IF
//f_activar_campo(em_remesa)
end event

type em_anyoret from u_em_campo within w_int_simul_remesas_expor_original
event getfocus pbm_ensetfocus
event losefocus pbm_enkillfocus
event modificado pbm_custom02
boolean visible = false
integer x = 2258
integer y = 260
integer width = 256
integer height = 76
integer taborder = 0
long backcolor = 16777215
string displaydata = ""
end type

event losefocus;call super::losefocus;f_activar_campo(em_remesa)
end event

event modificado;call super::modificado;f_activar_campo(em_remesa)
end event

type uo_tipo2 from u_marca_lista within w_int_simul_remesas_expor_original
boolean visible = false
integer x = 338
integer y = 780
boolean bringtotop = true
end type

on uo_tipo2.destroy
call u_marca_lista::destroy
end on

type cb_1 from commandbutton within w_int_simul_remesas_expor_original
integer x = 32
integer y = 428
integer width = 576
integer height = 76
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Tipo de Documento"
end type

event clicked;uo_tipodoc.visible = true

end event

type uo_tipodoc from u_marca_lista within w_int_simul_remesas_expor_original
event destroy ( )
boolean visible = false
integer x = 27
integer y = 500
integer width = 1454
integer height = 652
integer taborder = 60
boolean border = false
end type

on uo_tipodoc.destroy
call u_marca_lista::destroy
end on

type dw_efectos_marcados from datawindow within w_int_simul_remesas_expor_original
boolean visible = false
integer x = 1445
integer y = 4
integer width = 1061
integer height = 312
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Efectos marcados"
string dataobject = "dw_efectos_marcados_remesa"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

