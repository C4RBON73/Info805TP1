FROM openjdk:8 AS build
WORKDIR /src/
COPY ./ /src/
RUN ./gradlew build

FROM openjdk:8 as calc
COPY --from=build /src/build/libs/*.jar calc.jar
CMD ["java", "-jar", "calc.jar"]